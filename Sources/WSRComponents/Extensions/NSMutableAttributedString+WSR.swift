//
//  NSMutableAttributedString+WSR.swift
//  WSR
//
//  Created by William S. Rena on 9/10/24.
//

import UIKit

public extension NSMutableAttributedString {
    @discardableResult
    func insertImage(_ image: UIImage?, position: Int = 0,
                     origin: CGPoint? = nil, size: CGSize? = nil,
                     color: UIColor? = nil) -> Self {
        let attachment = NSTextAttachment()
        attachment.image = image
        let imageFrame = CGRect(origin: origin ?? .zero,
                                size: size ?? image?.size ?? .zero)
        attachment.bounds = imageFrame
        let attributedImage = NSMutableAttributedString(attachment: attachment)
        guard let color else {
            insert(attributedImage, at: position)
            return self
        }
        attributedImage.addAttribute(.foregroundColor, value: color, range: NSRange(location: 0, length: 1))
        insert(attributedImage, at: position)
        return self
    }

    @discardableResult
    func setParagraphStyle(_ style: NSParagraphStyle, range: NSRange? = nil) -> Self {
        addAttribute(NSAttributedString.Key.paragraphStyle,
                     value: style,
                     range: range ?? NSRange(location: 0, length: string.count))
        return self
    }
}
