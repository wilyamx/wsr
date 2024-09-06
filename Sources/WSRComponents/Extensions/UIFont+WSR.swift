//
//  UIFont+WSR.swift
//  WSR
//
//  Created by William Rena on 7/23/24.
//  Copyright © 2024 Personal. All rights reserved.
//

import UIKit

public extension UIFont {
    static var wsr_title: UIFont {
        .systemFont(ofSize: 25)
    }

    static var wsr_section: UIFont {
        .systemFont(ofSize: 20)
    }

    static var wsr_body: UIFont {
        .systemFont(ofSize: 18)
    }

    static var wsr_caption: UIFont {
        .systemFont(ofSize: 16)
    }

    static var wsr_captionSubtext: UIFont {
        .systemFont(ofSize: 14)
    }
}

public extension UIFont {
    func bold() -> UIFont {
        return .systemFont(ofSize: self.pointSize, weight: .bold)
    }

    func semibold() -> UIFont {
        return .systemFont(ofSize: self.pointSize, weight: .semibold)
    }
}
