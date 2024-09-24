//
//  WSREIndicatorController.swift
//  WSRExample
//
//  Created by William S. Rena on 9/11/24.
//  Copyright © 2024 Personal Use Only. All rights reserved.
//

import UIKit
import SuperEasyLayout
import WSRComponents_UIKit
import Lottie

@MainActor
class WSREIndicatorController: NSObject {
    enum CompletionType {
        typealias Delay = TimeInterval
        case check(Delay = 0)
        case exclamation
        case cross
        case none

        var delay: TimeInterval {
            switch self {
            case .check(let delay): delay
            default: 0
            }
        }
    }

    var indicatorWindow: UIWindow!
    weak var mainWindow: UIWindow?
    private var indicatorViewController: WSREIndicatorViewController!
    private(set) var isShowing = false

    static var shared = WSREIndicatorController()

    override init() {
        super.init()
        guard let scene = UIApplication.shared.connectedScenes.first(where: { [weak self] in
            guard let scene = $0 as? UIWindowScene,
                  let keyWindow = scene.windows.first(where: { $0.isKeyWindow })
            else { return false }
            self?.mainWindow = keyWindow
            return true
        }) as? UIWindowScene else { fatalError("Could not find scene.") }

        indicatorWindow = UIWindow(windowScene: scene)
        indicatorViewController = WSREIndicatorViewController()
        indicatorWindow.rootViewController = indicatorViewController
        indicatorWindow.windowLevel = .alert
        indicatorWindow.backgroundColor = UIColor.clear
    }

    private func showIndicator(_ message: String? = nil, isDone: Bool = false, completionHandler: @escaping () -> Void) {
        if isShowing {
            completionHandler()
            return
        }
        isShowing = true
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            indicatorWindow?.isHidden = false
            indicatorViewController.view.alpha = 0.0
            indicatorViewController.startAnimation(forDone: isDone)
            indicatorViewController.message = message
            UIView.animate(withDuration: 0.5, animations: {
                self.indicatorViewController.view.alpha = 1.0
            }, completion: { _ in
                completionHandler()
            })
        }
    }

    private func dismissIndicator(
        message: String? = nil, type: CompletionType = .none, completionHandler: (() -> Void)? = nil
    ) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            if !isShowing {
                completionHandler?()
                return
            }

            if let message {
                indicatorViewController.message = message
            }
            indicatorViewController.endAnimation(type: type) {
                UIView.animate(withDuration: 0.5, animations: { [weak self] in
                    self?.indicatorViewController.view.alpha = 0.0
                }, completion: { [weak self] _ in
                    if message == nil {
                        self?.indicatorViewController.message = nil
                    }
                    self?.indicatorWindow?.isHidden = true
                    self?.isShowing = false
                    completionHandler?()
                })
            }
        }
    }

    // MARK: - Public Methods
    
    func show(message: String? = nil, isDone: Bool = false) async {
        await withCheckedContinuation { continuation in
            showIndicator(message, isDone: isDone) { continuation.resume() }
        }
    }
    
    func dismiss(message: String? = nil, type: CompletionType = .none) async {
        await withCheckedContinuation { continuation in
            dismissIndicator(message: message, type: type) { continuation.resume() }
        }
    }

    func forceHidden() {
        indicatorWindow?.isHidden = true
        isShowing = false
    }
}

class WSREIndicatorViewController: WSRViewController {
    private lazy var verticalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 40
        view.alignment = .center
        return view
    }()

    private lazy var indicatorView = LottieAnimationView()

    private lazy var progressLabel: WSREPaddingLabel = {
        let view = WSREPaddingLabel()
        view.backgroundColor = .white
        view.padding = .init(top: 16, left: 16, bottom: 16, right: 16)
        view.font = .wsr_body
        view.textColor = .text
        view.textAlignment = .center
        view.numberOfLines = 0
        view.lineBreakMode = .byCharWrapping
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()

    var message: String? {
        get { progressLabel.text }
        set {
            progressLabel.isHidden = newValue == nil
            guard message != nil, let newValue else { return progressLabel.text = newValue }

            UIView.transition(
                with: verticalStackView, duration: 0.25, options: [.transitionCrossDissolve]
            ) { [weak self] in
                self?.progressLabel.text = newValue
            }
        }
    }

    // MARK: - Setups
    
    override func setupLayout() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.65)

        addSubviews([
            verticalStackView.addArrangedSubviews([
                indicatorView,
                progressLabel
            ])
        ])
    }

    override func setupConstraints() {
        verticalStackView.centerX == view.centerX
        verticalStackView.centerY == view.centerY

        indicatorView.width == 84
        indicatorView.height == 84

        progressLabel.width >= 224
        progressLabel.height >= 53
    }

    // MARK: - Public Methods
    
    func startAnimation(forDone: Bool = false) {
        let waitingAnimation = LottieAnimation.named(forDone ? "checkingAnimation" : "waitingAnimation")
        indicatorView.animation = waitingAnimation
        indicatorView.loopMode = .repeat(.infinity)
        indicatorView.play()
    }

    func endAnimation(type: WSREIndicatorController.CompletionType, completionHandler: (() -> Void)? = nil) {
        switch type {
        case .check(let delay):
            indicatorView.animation = LottieAnimation.named("checkingAnimation")
            indicatorView.loopMode = .playOnce
            indicatorView.play { completed in
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    completionHandler?()
                }
            }
        default:
            completionHandler?()
        }
    }
}
