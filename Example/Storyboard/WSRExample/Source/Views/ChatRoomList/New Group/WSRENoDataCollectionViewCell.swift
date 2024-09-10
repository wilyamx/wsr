//
//  WSRENoDataCollectionViewCell.swift
//  WSRExample
//
//  Created by William S. Rena on 9/9/24.
//  Copyright © 2024 Personal Use Only. All rights reserved.
//

import UIKit
import SuperEasyLayout
import WSRComponents

class WSRENoDataCollectionViewCell: WSRCollectionViewCell {
    private lazy var centerView = WSRView()

    private lazy var imageView: UIImageView = {
        let configuration = UIImage.SymbolConfiguration(pointSize: 100)
        let image = UIImage(
            systemName: "questionmark.diamond", withConfiguration: configuration
        )?.withRenderingMode(.alwaysTemplate)

        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFill
        view.tintColor = .accent
        return view
    }()

    private lazy var messageLabel: UILabel = {
        let view = UILabel()
        view.font = .wsr_body
        view.textAlignment = .center
        view.numberOfLines = 0
        view.lineBreakMode = .byCharWrapping
        view.text = "No Data"
        view.textColor = .accent
        return view
    }()

    override func setupLayout() {
        addSubviews([
            centerView.addSubviews([
                imageView,
                messageLabel
            ])
        ])
    }

    override func setupConstraints() {
        centerView.centerX == centerX
        centerView.centerY == centerY

        imageView.centerX == centerView.centerX
        imageView.top == centerView.top

        messageLabel.left >= centerView.left + 24
        messageLabel.right <= centerView.right - 24
        messageLabel.centerX == centerView.centerX
        messageLabel.top == imageView.bottom + 16
        messageLabel.bottom == centerView.bottom
    }
}
