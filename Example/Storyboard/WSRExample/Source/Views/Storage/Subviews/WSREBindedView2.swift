//
//  WSREBindedView2.swift
//  WSRExample
//
//  Created by William S. Rena on 9/19/24.
//  Copyright © 2024 Personal Use Only. All rights reserved.
//

import UIKit
import WSRComponents
import SuperEasyLayout
import SwiftUI

class WSREBindedView2: WSRView {
    private lazy var textLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = .wsr_title
        view.textColor = .text
        view.lineBreakMode = .byCharWrapping
        view.text = info
        return view
    }()
    
    @Binding var info: String?
    
    init(info: Binding<String?>) {
        _info = info
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setups
    
    override func setupLayout() {
        backgroundColor = .cyan
        
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
