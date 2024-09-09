//
//  WSRViewController.swift
//  WSR
//
//
//  Created by William S. Rena on 9/5/24.
//

import UIKit
import Combine

public protocol ViewControllerKeyboardAppear: AnyObject {
    func willShowKeyboard(frame: CGRect, duration: TimeInterval, curve: UIView.AnimationCurve)
    func willHideKeyboard(frame: CGRect, duration: TimeInterval, curve: UIView.AnimationCurve)
}

open class WSRViewController: UIViewController {
    public lazy var cancellables = Set<AnyCancellable>()
    
    public lazy var observers = [NSKeyValueObservation]()
    public lazy var objectProtocols = [NSObjectProtocol]()
    
    public weak var keyboardAppear: ViewControllerKeyboardAppear? { didSet {
        objectProtocols.append(contentsOf: [
            NotificationCenter.default.addObserver(
                forName: UIApplication.keyboardWillShowNotification,
                object: nil,
                queue: .main,
                using: { [weak self] in self?.notificationForWillShowKeyboard($0) }
            ),
            NotificationCenter.default.addObserver(
                forName: UIApplication.keyboardWillHideNotification,
                object: nil,
                queue: .main,
                using: { [weak self] in self?.notificationForWillHideKeyboard($0) }
            )
        ])
    } }
    
    // MARK: - View Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupLayout()
        setupConstraints()
        setupBindings()
        setupActions()
    }
    
    // MARK: - Setups

    open func setupNavigation() {}
    open func setupLayout() {}
    open func setupConstraints() {}
    open func setupBindings() {}
    open func setupActions() {}
    
    // MARK: - Navigation
    
    public func wsr_NavigationBarDefaultStyle(backgroundColor: UIColor = .black, tintColor: UIColor = .white) {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = backgroundColor
            appearance.shadowColor = .clear

            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance

            let titleAttribute = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .regular),
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
            appearance.titleTextAttributes = titleAttribute
        } else {
            let navigationBar = navigationController?.navigationBar
            navigationBar?.standardAppearance.backgroundColor = backgroundColor
            navigationBar?.standardAppearance.shadowColor = .clear
        }
        navigationController?.navigationBar.tintColor = tintColor
        navigationItem.backButtonTitle = ""
    }
}

// MARK: - Notifications

extension WSRViewController {
    private func notificationForWillShowKeyboard(_ notification: Notification) {
        guard
            let delegate = keyboardAppear,
            let userInfo = notification.userInfo,
            let endFrameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let durationNumber = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber,
            let curveNumber = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber,
            let curve = UIView.AnimationCurve(rawValue: curveNumber.intValue)
        else {
            return
        }
        let endFrame = endFrameValue.cgRectValue
        let duration = durationNumber.doubleValue

        delegate.willShowKeyboard(frame: endFrame, duration: duration, curve: curve)
    }

    private func notificationForWillHideKeyboard(_ notification: Notification) {
        guard
            let delegate = keyboardAppear,
            let userInfo = notification.userInfo,
            let endFrameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let durationNumber = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber,
            let curveNumber = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber,
            let curve = UIView.AnimationCurve(rawValue: curveNumber.intValue)
        else {
            return
        }
        let endFrame = endFrameValue.cgRectValue
        let duration = durationNumber.doubleValue

        delegate.willHideKeyboard(frame: endFrame, duration: duration, curve: curve)
    }
}
