//
//  WSRSearchBarView.swift
//
//
//  Created by William S. Rena on 9/10/24.
//

import Foundation
import SuperEasyLayout
import UIKit
import Combine

open class WSRSearchBarView: WSRView {
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.backgroundColor = .clear
        return view
    }()

    private lazy var searchLeftView: WSRView = {
        let image = UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.tintColor = UIColor.getPackageColor(named: "wsr_accent")

        let view = WSRView()
        view.addSubviews([imageView])
        imageView.left == view.left + 12
        imageView.width == 24
        imageView.centerY == view.centerY
        imageView.height == 24
        return view
    }()

    private lazy var searchTextField: WSRTextField = {
        let view = WSRTextField()

        view.placeholderFont = .wsr_body
        view.placeholderColor = UIColor.getPackageColor(named: "wsr_text")
        view.placeholder = "Search by name"

        view.backgroundColor = .white
        view.layer.cornerRadius = 22

        view.leftView = searchLeftView
        view.leftViewWidth = 40
        view.leftViewMode = .always

        view.hasClearButton = true
        view.rightViewWidth = 44
        view.autocapitalizationType = .none
        return view
    }()

    private lazy var containerView: WSRView = {
        let view = WSRView()
        view.addSubviews([searchTextField])
        searchTextField.left == view.left
        searchTextField.right == view.right
        searchTextField.top == view.top
        searchTextField.height == 44
        return view
    }()

    private lazy var errorLabel: UILabel = {
        let image = UIImage(systemName: "exclamationmark.triangle.fill")?.withRenderingMode(.alwaysTemplate)
        let view = UILabel()
        view.numberOfLines = 0
        view.lineBreakMode = .byCharWrapping
        view.attributedText = "Error"
            .getAttributedString(with: .wsr_caption, color: imageTintColor)
            .setParagraphStyle(NSMutableParagraphStyle().setLineSpacing(5))
            .insertImage(image, origin: CGPoint(x: 0, y: -5))
        view.isHidden = true
        return view
    }()

    public var textPublisher: AnyPublisher<String?, Never> {
        searchTextField.textPublisher
    }

    public var needToShowError = false { didSet {
        errorLabel.isHidden = !needToShowError
    } }

    public var placeholderColor: UIColor = UIColor.getPackageColor(named: "wsr_text") { didSet {
        searchTextField.placeholderColor = placeholderColor
        searchTextField.placeholder = "Search by name"
    } }
    
    public var imageTintColor: UIColor = UIColor.getPackageColor(named: "wsr_accent") { didSet {
        if let imageView = searchLeftView.subviews.first as? UIImageView {
            imageView.tintColor = imageTintColor
        }
        searchTextField.clearButton.tintColor = imageTintColor
    } }
    
    // MARK: - Setups
    
    open override func setupLayout() {
        backgroundColor = .clear
        
        addSubviews([
            stackView.addArrangedSubviews([
                containerView,
                errorLabel
            ])
        ])
    }

    open override func setupConstraints() {
        stackView.left == left + 10
        stackView.right == right - 10
        stackView.top == top
        stackView.bottom == bottom

        containerView.height == 44
    }

    @discardableResult
    open override func resignFirstResponder() -> Bool {
        searchTextField.resignFirstResponder()
    }

    public func setInitTerm(_ term: String) {
        guard term != searchTextField.text else { return }
        searchTextField.text = term
    }
}
