//
//  WSRConstants.swift
//  WSR
//
//  Created by William Rena on 7/27/24.
//  Copyright © 2024 Personal. All rights reserved.
//

import UIKit

// MARK: - App specification infos

public class WSRConstants {
    public static var appVersion: String = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""

    public static var appName: String = (Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String) ?? ""

    public static var documentsURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    public static var keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?
            .windows
            .first(where: \.isKeyWindow)
    }

    public static var safeAreaInsets: UIEdgeInsets {
        guard let keyWindow
        else { fatalError("There is no keyWindow. You must check source.") }
        return keyWindow.safeAreaInsets
    }

    public static var statusBarHeight: CGFloat {
        keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }

    public static var hasSafeAreaBottomMargin: Bool { WSRConstants.safeAreaInsets.bottom > 0 }
}
