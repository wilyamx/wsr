//
//  WSREBindedView.swift
//  WSRExample
//
//  Created by William S. Rena on 9/17/24.
//  Copyright © 2024 Personal Use Only. All rights reserved.
//

import UIKit
import SwiftUI
import WSRComponents_UIKit
import SuperEasyLayout

class WSREBindedView: WSRView {
    private lazy var textLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = .wsr_title
        view.textColor = .text
        view.lineBreakMode = .byCharWrapping
        view.text = userInfo?.name
        return view
    }()
    
    @Binding var userInfo: UserInfo?
    
    init(userInfo: Binding<UserInfo?>) {
        _userInfo = userInfo
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
