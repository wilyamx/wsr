//
//  BaseCollectionViewCell.swift
//  WSR
//
//  Created by William Rena on 8/19/24.
//

import UIKit

open class WSRCollectionViewCell: UICollectionViewCell {
    public var tapHandler: ((WSRCollectionViewCell) -> Void)?
    public var tapHandlerAsync: ((WSRCollectionViewCell) async -> Void)?

    private var originSelectionBackViewBackgroundColor: UIColor?
    public var selectionBackView: UIView? {
        didSet {
            guard let view = selectionBackView else {
                originSelectionBackViewBackgroundColor = .white
                return
            }
            originSelectionBackViewBackgroundColor = view.backgroundColor
        }
    }
    private weak static var tappingCell: WSRCollectionViewCell?
    private static var tapControllSemaphore = DispatchSemaphore(value: 0)
    private static var tapQueue = DispatchQueue(label: "CollectionViewCellTapQueue")

    // MARK: - Class Methods
    
    public class var identifier: String {
        let name = NSStringFromClass(self)
        let components = name.components(separatedBy: ".")
        return components.last ?? "Unknown" + "Identifier"
    }

    public class func registerCell(to collectionView: UICollectionView) {
        collectionView.register(self, forCellWithReuseIdentifier: identifier)
    }

    public class func dequeueCell(from collectionView: UICollectionView, for indexPath: IndexPath) -> Self {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: identifier, for: indexPath
        ) as? Self else {
            fatalError("Could not get cell object. identifier => \(identifier)")
        }
        return cell
    }

    // MARK: - Instantiation

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    deinit {

    }

    // MARK: - Other Methods
    
    open override var reuseIdentifier: String? {
        WSRCollectionViewCell.identifier
    }
    
    open override func prepareForReuse() {

    }

    // MARK: - Setups
    
    private func setup() {
        setupLayout()
        setupConstraints()
        setupBindings()
        setupActions()
    }

    open func setupLayout() {}
    open func setupConstraints() {}
    open func setupBindings() {}
    open func setupActions() {}
}

extension WSRCollectionViewCell {
    func tryTap() -> Bool {
        var result = false
        WSRCollectionViewCell.tapQueue.async {
            if WSRCollectionViewCell.tappingCell != nil {
                result = false
            } else {
                WSRCollectionViewCell.tappingCell = self
                result = true
            }
            WSRCollectionViewCell.tapControllSemaphore.signal()
        }
        WSRCollectionViewCell.tapControllSemaphore.wait()
        return result
    }

    func releaseTap() {
        WSRCollectionViewCell.tapQueue.async {
            if WSRCollectionViewCell.tappingCell == self {
                WSRCollectionViewCell.tappingCell = nil
            }
            WSRCollectionViewCell.tapControllSemaphore.signal()
        }
        WSRCollectionViewCell.tapControllSemaphore.wait()
    }

    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let selectionBackView,
              let touchPoint = touches.first?.location(in: self),
              selectionBackView.frame.contains(touchPoint),
              tryTap()
        else { return }

        super.touchesBegan(touches, with: event)
    }

    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let tapHandlerAsync {
            Task { [weak self] in
                guard let self else { return }
                await tapHandlerAsync(self)
            }
        } else {
            tapHandler?(self)
        }
        super.touchesEnded(touches, with: event)
    }
}
