//
//  BaseView.swift
//  WSR
//
//  Created by William Rena on 8/19/24.
//

import UIKit
import Combine

open class WSRView: UIView {
    lazy var observers = [NSKeyValueObservation]()
    lazy var cancellables = Set<AnyCancellable>()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        setupLayout()
        setupConstraints()
        setupBindings()
        setupActions()
    }

    // MARK: - Setups
    
    open func setupLayout() {}
    open func setupConstraints() {}
    open func setupBindings() {}
    open func setupActions() {}
}
