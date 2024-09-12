//
//  WSREPaddingLabel.swift
//  WSRExample
//
//  Created by William S. Rena on 9/11/24.
//  Copyright © 2024 Personal Use Only. All rights reserved.
//

import UIKit

class WSREPaddingLabel: UILabel {
    var padding: UIEdgeInsets = .zero

    override func drawText(in rect: CGRect) {
        let newRect = rect.inset(by: padding)
        super.drawText(in: newRect)
    }

    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width += padding.left + padding.right
        size.height += padding.top + padding.bottom
        return size
    }
}
