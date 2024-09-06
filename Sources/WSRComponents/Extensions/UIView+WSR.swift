//
//  UIView+WSR.swift
//  WSR
//
//  Created by William Rena on 7/23/24.
//  Copyright © 2024 Personal. All rights reserved.
//

import UIKit
import SuperEasyLayout

public extension UIView {
    @discardableResult
    func addSubviews(_ views: [UIView]) -> UIView {
        views.forEach { addSubview($0) }
        return self
    }
    
    func setLayoutEqualTo(_ view: UIView, margins: UIEdgeInsets = .zero) {
        top == view.top + margins.top
        left == view.left + margins.left
        right == view.right - margins.right
        bottom == view.bottom - margins.bottom
    }

    func setLayoutEqualTo(_ view: UIView, space: CGFloat) {
        top == view.top + space
        left == view.left + space
        right == view.right - space
        bottom == view.bottom - space
    }

    func setLayoutEqualTo(
        _ view: UIView,
        leftMargin: CGFloat = 0,
        rightMargin: CGFloat = 0,
        topMargin: CGFloat = 0,
        bottomMargin: CGFloat = 0
    ) {
        top == view.top + topMargin
        left == view.left + leftMargin
        right == view.right - rightMargin
        bottom == view.bottom - bottomMargin
    }

    func addShadowOval(color: UIColor? = .black,
                   alpha: CGFloat = 1,
                   offset: CGSize = .zero,
                   blur: CGFloat = 0,
                   spread: CGFloat = 0) {
        layer.shadowColor = color?.cgColor
        layer.shadowOpacity = Float(alpha)
        layer.shadowOffset = offset
        layer.shadowRadius = blur / 2
        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            layer.shadowPath = UIBezierPath(ovalIn: rect).cgPath
        }
    }
}
