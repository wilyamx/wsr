//
//  WSRBrightnessManager.swift
//  WSR
//
//  Created by William S. Rena on 9/25/24.
//

import Foundation
import UIKit

final public class WSRBrightnessManager {
    private var timer: Timer?
    private var isBrighteningScreen = false
    private var isDarkeningScreen = false

    private init() { }

    public static let shared = WSRBrightnessManager()

    public func brightenDisplay() {
        resetTimer()
        isBrighteningScreen = true
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (timer) in
                UIScreen.main.brightness = UIScreen.main.brightness + 0.05
                if UIScreen.main.brightness > 0.99 || !self.isBrighteningScreen {
                    self.resetTimer()
                }
            }
        }
        timer?.fire()
    }

    public func darkenDisplay(until: CGFloat) {
        resetTimer()
        isDarkeningScreen = true
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (timer) in
                UIScreen.main.brightness = max(UIScreen.main.brightness - 0.05, until)
                if UIScreen.main.brightness <= until || !self.isDarkeningScreen {
                    self.resetTimer()
                }
            }
        }
        timer?.fire()
    }

    private func resetTimer() {
        timer?.invalidate()
        timer = nil
        isBrighteningScreen = false
        isDarkeningScreen = false
    }
}

