//
//  NSMutableParagraphStyle+WSR.swift
//  WSR
//
//  Created by William S. Rena on 9/10/24.
//

import UIKit

public extension NSMutableParagraphStyle {
    @discardableResult
    func setLineSpacing(_ lineSpacing: CGFloat) -> Self {
        self.lineSpacing = lineSpacing
        return self
    }

    @discardableResult
    func setLineHeight(_ lineHeight: CGFloat) -> Self {
        minimumLineHeight = lineHeight
        maximumLineHeight = lineHeight
        return self
    }

    @discardableResult
    func setLineBreakMode(_ lineBreakMode: NSLineBreakMode) -> Self {
        self.lineBreakMode = lineBreakMode
        return self
    }

    @discardableResult
    func setAlignment(_ alignment: NSTextAlignment) -> Self {
        self.alignment = alignment
        return self
    }
}
