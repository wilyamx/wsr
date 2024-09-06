//
//  BaseNavigationBar.swift
//  WSR
//
//  Created by William Rena on 8/20/24.
//

import UIKit
import SuperEasyLayout

open class WSRNavigationBar: UINavigationBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        setupLayout()
        setupConstraints()
        setupBindings()
        setupActions()
    }

    open func setupLayout() {}
    open func setupConstraints() {}
    open func setupBindings() {}
    open func setupActions() {}

    open override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func setBackButtonConstraints(_ backButton: UIView, superview: UIView) {
        guard backButton.constraints.filter({ $0.identifier == "NewBackButtonLeftConstraint" }).isEmpty else { return }

        if #available(iOS 14, *) {
            guard let targetConstraint = backButton.constraints.filter({ $0.identifier == "Mask_Leading_Leading" }).first,
                  targetConstraint.isActive
            else { return }

            targetConstraint.isActive = false
        }

        let constraint = backButton.left ! .required == superview.left + 16
        backButton.width ! .required == 44
        constraint.identifier = "NewBackButtonLeftConstraint"
    }
}
