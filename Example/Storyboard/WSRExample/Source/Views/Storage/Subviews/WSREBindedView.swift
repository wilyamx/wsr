//
//  WSREBindedView.swift
//  WSRExample
//
//  Created by William S. Rena on 9/17/24.
//  Copyright © 2024 Personal Use Only. All rights reserved.
//

import UIKit
import WSRComponents
import SuperEasyLayout

class WSREBindedView: WSRView {
    private lazy var textLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = .wsr_title
        view.textColor = .text
        view.lineBreakMode = .byCharWrapping
        view.text = "???"
        return view
    }()
    
    // MARK: - Setups
    
    override func setupLayout() {
        backgroundColor = .yellow
        
        addSubviews([
            textLabel
        ])
    }
    
    override func setupConstraints() {
        textLabel.left == left + 5
        textLabel.right == right - 5
        textLabel.top == top + 5
        textLabel.bottom == bottom - 5
    }
}
