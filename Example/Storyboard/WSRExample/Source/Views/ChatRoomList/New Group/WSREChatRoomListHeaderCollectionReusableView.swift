//
//  WSREChatRoomListHeaderCollectionReusableView.swift
//  WSRExample
//
//  Created by William S. Rena on 9/10/24.
//  Copyright © 2024 Personal Use Only. All rights reserved.
//

import UIKit
import WSRComponents
import SuperEasyLayout

class WSREChatRoomListHeaderCollectionReusableView: WSRCollectionReusableView {
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        //view.font = .body
        //view.textColor = .textColor(.title)
        return view
    }()

    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }

    override func setupLayout() {
        addSubviews([
            titleLabel
        ])
    }

    override func setupConstraints() {
        titleLabel.left == left + 20
        titleLabel.right == right - 20
        titleLabel.centerY == centerY
    }
}
