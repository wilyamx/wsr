//
//  UIView+WSR.swift
//  WSR
//
//  Created by William Rena on 7/23/24.
//  Copyright © 2024 Personal. All rights reserved.
//

import UIKit

public extension UIView {
    @discardableResult
    func addSubviews(_ views: [UIView]) -> UIView {
        views.forEach { addSubview($0) }
        return self
    }
}
