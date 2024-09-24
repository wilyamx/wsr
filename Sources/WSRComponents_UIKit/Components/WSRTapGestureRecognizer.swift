//
//  BaseTapGestureRecognizer.swift
//  WSR
//
//  Created by Ramon Jr Bahio on 8/21/24.
//

import UIKit

open class WSRTapGestureRecognizer: UITapGestureRecognizer {
    private var isInitialized = false

    var tapHandler: ((UITapGestureRecognizer) -> Void)? { didSet {
        guard !isInitialized else { return }
        isInitialized = true
        addTarget(self, action: #selector(tapped(_:)))
    } }

    var tapHandlerAsync: ((UITapGestureRecognizer) async -> Void)? { didSet {
        guard !isInitialized else { return }
        isInitialized = true
        addTarget(self, action: #selector(tapped(_:)))
    } }

    init(on view: UIView) {
        super.init(target: nil, action: nil)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(self)
    }

    public func registerGesture(on view: UIView) {
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(self)
    }

    @objc private func tapped(_: UITapGestureRecognizer) {
        if let tapHandler {
            tapHandler(self)
        } else if let tapHandlerAsync {
            Task { await tapHandlerAsync(self) }
        }
    }
}

