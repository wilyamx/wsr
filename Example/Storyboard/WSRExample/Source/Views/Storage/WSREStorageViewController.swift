//
//  WSREStorageViewController.swift
//  WSRExample
//
//  Created by William S. Rena on 9/17/24.
//  Copyright © 2024 Personal Use Only. All rights reserved.
//

import UIKit
import SwiftUI
import WSRComponents
import WSRStorage
import WSRUtils
import SuperEasyLayout

struct UserInfo: Codable {
    var id = UUID().uuidString
    var name: String
}

class WSREStorageViewController: WSREViewController {

    private lazy var verticalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        return view
    }()
    
    private lazy var dataChangeTextLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = .wsr_captionSubtext
        view.textColor = .text
        view.lineBreakMode = .byCharWrapping
        view.text = "Listening Data Change"
        view.backgroundColor = .yellow
        return view
    }()
    
    private lazy var bindedView: WSREBindedView = {
        let view = WSREBindedView(userInfo: $infoWrapper2.projectedValue)
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var bindedView2: WSREBindedView2 = {
        let view = WSREBindedView2(info: $info.binding.projectedValue)
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var propertyWrapperButton: WSRButton = {
        let view = WSRButton()
        view.text = "PROPERTY WRAPPER"
        view.colorStyle = .active
        view.layer.cornerRadius = 8
        return view
    }()
    
    @FileManagerCodableProperty("userInfo2") private var infoWrapper2: UserInfo?
    @UppercaseProperty private var info: String = "default"
    
    //@WSRUserDefaults_UIKit("name3", default: "Default Name1") private var name: String
    @WSRUserDefaultsReadOnly("name3", defaultValue: "Default Name2") private var nameGetter: String
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //wsrLogger.info(message: "@WSRUserDefaults_UIKit: \(name)")
        wsrLogger.info(message: "@WSRUserDefaultsReadOnly: \(nameGetter)")
    }
    
    // MARK: - Setups
    
    override func setupNavigation() {
        title = "Property Wrappers"
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        addSubviews([
            bindedView,
            bindedView2,
            verticalStackView.addArrangedSubviews([
                propertyWrapperButton
            ])
        ])
    }
    
    override func setupConstraints() {
        bindedView.left == view.left + 20
        bindedView.right == view.right - 20
        bindedView.top == view.topMargin + 20
        bindedView.height == 100
        
        bindedView2.left == view.left + 20
        bindedView2.right == view.right - 20
        bindedView2.top == bindedView.bottom + 20
        bindedView2.height == 100
        
        verticalStackView.left == view.left + 20
        verticalStackView.right == view.right - 20
        verticalStackView.centerY == view.centerY
        
        propertyWrapperButton.height == 44
    }
    
    override func setupActions() {
        propertyWrapperButton.tapHandlerAsync = { [weak self] _ in
            DispatchQueue.main.async {
                //self?.infoWrapper2 = UserInfo(name: "\(Date())")
                //self?.bindedView.userInfo = UserInfo(name: "\(Date())")
                //self?.info = "information"
                
                //self?.name = "Amazing Race!"
            }
        }
    }
}
