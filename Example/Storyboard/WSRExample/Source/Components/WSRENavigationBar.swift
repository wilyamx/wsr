//
//  WSRENavigationBar.swift
//  WSRExample
//
//  Created by William S. Rena on 9/10/24.
//  Copyright © 2024 Personal Use Only. All rights reserved.
//

import UIKit
import WSRComponents
import SuperEasyLayout

class WSRENavigationBar: WSRNavigationBar {
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .wsr_section
        view.textColor = .textLight
        view.textAlignment = .center
        return view
    }()
    
    private lazy var profileImageView: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "person.crop.circle.fill")?
            .withRenderingMode(.alwaysTemplate))
        view.contentMode = .scaleAspectFit
        view.tintColor = .accent
        view.backgroundColor = .mainBackground
        view.layer.cornerRadius = 22
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var closeButton: WSRButton = {
        let configuration = UIImage.SymbolConfiguration(pointSize: 30)
        let image = UIImage(systemName: "xmark", withConfiguration: configuration)?
            .withRenderingMode(.alwaysTemplate)

        let view = WSRButton(image: image)
        view.tintColor = .textLight
        view.setBackgroundColor(.clear, for: .normal)
        return view
    }()
    
    var title: String = "" { didSet {
        titleLabel.text = title
    } }
    
    var closeTapHandlerAsync: ((WSRButton) async -> Void)?
    var profileTapHandlerAsync: ((UIImageView) async -> Void)?
    
    // MARK: - Navigation Button Options
    
    var showDismissButtonOnly: Bool = false { didSet {
        profileImageView.isHidden = false
        closeButton.isHidden = false

        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.profileImageView.alpha = 0
            self?.closeButton.alpha = 1
        } completion: { [weak self] _ in
            self?.profileImageView.isHidden = true
        }
    } }
    
    var showProfileButtons: Bool = false { didSet {
        profileImageView.isHidden = false
        closeButton.isHidden = false

        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.profileImageView.alpha = 1
            self?.closeButton.alpha = 1
        } completion: { [weak self] _ in
            
        }
    } }
    
    // MARK: - Setups
    
    override func setupLayout() {
        addSubviews([
            titleLabel,
            profileImageView,
            //invitationButton,
            //moreButton,
            closeButton
        ])
        
        titleTextAttributes = [NSAttributedString.Key.backgroundColor: UIColor.mainBackground,
                               NSAttributedString.Key.foregroundColor: UIColor.textLight,
                               NSAttributedString.Key.font: UIFont.wsr_body]
    }
    
    override func setupConstraints() {
        titleLabel.left == left + 74
        titleLabel.right == right - 74
        titleLabel.height == 50
        titleLabel.centerY == centerY
        
        profileImageView.left == left + 22
        profileImageView.bottom == bottom - 5
        profileImageView.width == 44
        profileImageView.height == 44
        
        closeButton.right == right - 18
        closeButton.width == 44
        closeButton.height == 44
        closeButton.centerY == centerY
    }
    
    override func setupActions() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped(_:)))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tapRecognizer)
        
        closeButton.tapHandlerAsync = { [weak self] _ in
            guard let self else { return }
            await closeTapHandlerAsync?(closeButton)
        }
    }
    
    // MARK: - Actions
    
    @objc
    func profileImageTapped(_ sender: UITapGestureRecognizer) {
        Task { await profileTapHandlerAsync?(profileImageView) }
    }
}
