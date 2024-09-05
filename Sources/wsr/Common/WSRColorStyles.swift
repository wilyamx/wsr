//
//  WSRColorStyles.swift
//
//
//  Created by William S. Rena on 9/5/24.
//

import UIKit

public enum WSRColorStyle: Hashable {
    case active
    case inactive

    var backgroundColor: UIColor {
        switch self {
        case .active: .white //.button(.active)
        case .inactive: .white //.button(.ongoing)
        }
    }

    var textColor: UIColor {
        switch self {
        case .active: .white
        case .inactive: .white //.subText
        }
    }

    var disabledBackgroundColor: UIColor {
        switch self {
        case .active: .white //.subText
        case .inactive: .white //.subText
        }
    }
    
    var disabledTextColor: UIColor {
        switch self {
        case .active: .white //.textLight
        case .inactive: .white //.textLight
        }
    }
}
