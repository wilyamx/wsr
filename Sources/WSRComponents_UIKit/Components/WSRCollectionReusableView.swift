//
//  BaseCollectionReusableView.swift
//  WSR
//
//  Created by William Rena on 8/19/24.
//

import UIKit
import Combine

open class WSRCollectionReusableView: UICollectionReusableView {
    
    public lazy var cancellables = Set<AnyCancellable>()
    
    // MARK: - Class Methods and Properties
    
    public class var isHeader: Bool { fatalError("You must set isHeader.") }
    public class var viewOfKind: String { identifier }
    
    public class var identifier: String {
        let name = NSStringFromClass(self)
        let components = name.components(separatedBy: ".")
        return components.last ?? "Unknown" + "Identifier"
    }

    public class func registerView(to collectionView: UICollectionView) {
        collectionView.register(
            self,
            forSupplementaryViewOfKind: viewOfKind,
            withReuseIdentifier: identifier
        )
    }

    public class func dequeueView(from collectionView: UICollectionView,
                           for indexPath: IndexPath) -> Self {
        guard let view = collectionView.dequeueReusableSupplementaryView(
            ofKind: viewOfKind,
            withReuseIdentifier: identifier,
            for: indexPath
        ) as? Self
        else { fatalError("Could not get view object. identifier => \(identifier)") }
        return view
    }

    // MARK: - Instantiation
    
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
