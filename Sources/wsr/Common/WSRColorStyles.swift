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
        case .active: UIColor(named: "main", in: .module, compatibleWith: nil)!
        case .inactive: UIColor(named: "accentSecondary", in: .module, compatibleWith: nil)!
        }
    }

    var textColor: UIColor {
        switch self {
        case .active: .white
        case .inactive: UIColor(named: "subText", in: .module, compatibleWith: nil)!
        }
    }

    var disabledBackgroundColor: UIColor {
        switch self {
        case .active: UIColor(named: "subText", in: .module, compatibleWith: nil)!
        case .inactive: UIColor(named: "subText", in: .module, compatibleWith: nil)!
        }
    }
    
    var disabledTextColor: UIColor {
        switch self {
        case .active: UIColor(named: "textLight", in: .module, compatibleWith: nil)!
        case .inactive: UIColor(named: "textLight", in: .module, compatibleWith: nil)!
        }
    }
}
