//
//  String+WSR.swift
//  WSR
//
//  Created by William Rena on 7/23/24.
//  Copyright © 2024 Personal. All rights reserved.
//

import UIKit

public extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func getAttributedString(with font: UIFont,
                             color: UIColor? = .darkText,
                             attributes: [NSAttributedString.Key: Any]? = nil) -> NSMutableAttributedString {
        var attr: [NSAttributedString.Key: Any] = [.font: font]
        if let color {
            attr[.foregroundColor] = color
        }
        if let attributes {
            attr = attr.merging(attributes, uniquingKeysWith: { value1, _ -> Any in
                value1
            })
        }

        let attributedString = NSMutableAttributedString(string: self)

        attributedString.addAttributes(attr, range: NSRange(location: 0, length: utf16.count))

        return attributedString
    }
}
