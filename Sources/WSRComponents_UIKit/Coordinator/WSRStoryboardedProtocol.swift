//
//  WSRStoryboardedProtocol.swift
//  WSR
//
//  Created by William Rena on 6/28/23.
//

import UIKit

public protocol WSRStoryboarded {
    static func instantiate() -> Self
}

public extension WSRStoryboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
