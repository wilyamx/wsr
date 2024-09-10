//
//  BaseTextField.swift
//  WSR
//
//  Created by William Rena on 8/20/24.
//

import UIKit
import Combine
import SuperEasyLayout

@objc protocol WSRTextFieldDelegate: NSObjectProtocol {
    @objc optional func tappedBackword(_ textField: WSRTextField)
}

open class WSRTextField: UITextField {
    lazy var clearButton: WSRButton = {
        let configuration = UIImage.SymbolConfiguration(pointSize: 25)
        let image = UIImage(
            systemName: "x.circle.fill", withConfiguration: configuration
        )?.withRenderingMode(.alwaysTemplate)

        let view = WSRButton(image: image)
        view.setBackgroundColor(.clear, for: .normal)
        view.width == 44
        view.height == 44
        view.tintColor = UIColor.getPackageColor(named: "wsr_accent")
        return view
    }()

    private lazy var hideButton: UIButton = {
        let button = WSRButton()
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        button.tintColor = UIColor.getPackageColor(named: "wsr_accent")
        button.tapHandler = { [weak self] _ in
            guard let self, isSecureMode else { return }
            isHiding.toggle()
        }
        return button
    }()

    weak var baseTextFieldDelegate: WSRTextFieldDelegate?
    var leftViewWidth: CGFloat?
    var rightViewWidth: CGFloat?

    var isSelectable = true
    var maxLength: Int?
    var isKanjiConversioning: Bool { markedTextRange != nil }
    var rightViewRightMargin: CGFloat = 0

    /// Placeholder関連
    var placeholderFont: UIFont = .preferredFont(forTextStyle: .caption1)
    var placeholderColor: UIColor? = UIColor.getPackageColor(named: "wsr_text")
    open override var placeholder: String? {
        get { attributedPlaceholder?.string }
        set {
            guard let newValue else {
                attributedPlaceholder = nil
                return
            }
            attributedPlaceholder = newValue
                .getAttributedString(with: placeholderFont,
                                     color: placeholderColor)
        }
    }

    weak var nextField: WSRTextField?
    public var onBeginEdit: ((WSRTextField) -> Void)?
    public var onSubmit: ((WSRTextField) -> Void)?
    public var onSubmitAsync: ((WSRTextField) async -> Void)?
    public var onChanged: ((WSRTextField, String?) -> Void)?
    public var shouldClear: ((WSRTextField) -> Bool)?
    public var shouldChangeHandler: ((WSRTextField, String, String, NSRange, String) -> (Int?, String?))?
    public lazy var textPublisher: AnyPublisher<String?, Never> = _textPublisher.eraseToAnyPublisher()
    private let _textPublisher = PassthroughSubject<String?, Never>()
    @Published var hasFocus: Bool = false { willSet {
        isBorderHidden = !newValue
    } }

    open override var text: String? {
        get { super.text }
        set {
            super.text = newValue
            onChangedText()
        }
    }

    var hasClearButton: Bool = false { didSet {
        guard hasClearButton else { return }

        rightViewWidth = 44
        rightView = clearButton
        rightViewMode = .always
        addSubview(clearButton)
        clearButton.right == right
        clearButton.centerY == centerY
        clearButton.isHidden = text?.isEmpty ?? true
        clearButton.tapHandler = { [weak self] _ in
            guard let self, delegate?.textFieldShouldClear?(self) ?? true,
                  shouldClear?(self) ?? true
            else { return }

            text = nil
            onChangedText()
        }
    } }

    var isSecureMode: Bool = false {
        didSet {
            guard isSecureMode, !oldValue, rightView !== hideButton else { return }

            isSecureTextEntry = true
            rightView = hideButton
            rightViewMode = .whileEditing
        }
    }

    var isHiding: Bool {
        get { isSecureMode ? isSecureTextEntry : false }
        set {
            guard isSecureMode else { return }

            isSecureTextEntry = newValue
            hideButton.setImage(UIImage(systemName: isSecureTextEntry ? "eye.fill" : "eye.slash.fill")?
                .withRenderingMode(.alwaysTemplate),
                                for: .normal)
        }
    }

    var isBorderHidden: Bool {
        get { layer.borderColor == UIColor.clear.cgColor }
        set { layer.borderColor = newValue ? UIColor.clear.cgColor : 
            UIColor(named: "wsr_main", in: .module, compatibleWith: nil)!.cgColor }
    }

    // MARK: - Instantiations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Setups
    
    private func setup() {
        addTarget(self, action: #selector(onChangedText), for: .editingChanged)
        delegate = self
        layer.borderWidth = 1
        layer.borderColor = UIColor.clear.cgColor

        setupLayout()
        setupConstraints()
        setupBindings()
        setupActions()
    }
    
    open func setupLayout() {}
    open func setupConstraints() {}
    open func setupBindings() {}
    open func setupActions() {}

    // MARK: - Other Methods
    
    open override func deleteBackward() {
        if text == "" { baseTextFieldDelegate?.tappedBackword?(self) }
        super.deleteBackward()
    }

    open override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        guard let leftViewWidth else { return super.leftViewRect(forBounds: bounds) }

        return CGRect(x: 0.0, y: 0.0, width: leftViewWidth, height: bounds.height)
    }

    open override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        guard let rightViewWidth else { return super.rightViewRect(forBounds: bounds) }

        return CGRect(
            x: bounds.width - rightViewWidth + rightViewRightMargin,
            y: 0.0,
            width: rightViewWidth,
            height: bounds.height
        )
    }

    open override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        isSecureMode ? [] : super.selectionRects(for: range)
    }

    // MARK: - Handlers
    
    @objc func onChangedText() {
        guard markedTextRange == nil else { return }

        if hasClearButton {
            clearButton.isHidden = text?.isEmpty ?? true
        }
        onChanged?(self, text)
        _textPublisher.send(text)
    }
}

extension WSRTextField: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_: UITextField) -> Bool {
        onBeginEdit?(self)
        hasFocus = true
        return true
    }

    public func textFieldShouldEndEditing(_: UITextField) -> Bool {
        hasFocus = false
        return true
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        hasFocus = false
    }

    public func textFieldShouldReturn(_: UITextField) -> Bool {
        if let next = nextField {
            next.becomeFirstResponder()
        } else {
            resignFirstResponder()
        }
        hasFocus = false
        if let onSubmitAsync {
            Task {
                await onSubmitAsync(self)
            }
        } else if let onSubmit {
            onSubmit(self)
        }
        return false
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn nsRange: NSRange,
                   replacementString string: String) -> Bool {
        guard let text,
              let range = Range(nsRange, in: text)
        else { return true }

        let newText = text.replacingCharacters(in: range, with: string)
        guard let handler = shouldChangeHandler else { return newText.count <= (maxLength ?? .max) }

        let (cursorPosition, newString) = handler(self, text, newText, nsRange, string)
        guard let cursorPosition, let newString else { return true }

        textField.text = newString
        //textField.cursorPosition = cursorPosition

        return false
    }
}
