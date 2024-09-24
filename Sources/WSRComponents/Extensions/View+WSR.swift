//
//  View+WSR.swift
//  WSR
//
//  Created by William S. Rena on 9/24/24.
//

import SwiftUI
import WSRNetworking

// MARK: - WSRButtonLabelModifier

public extension View {
    func wsr_ButtonLabel(bgColor: Color, fgColor: Color, font: Font? = nil) -> some View {
        modifier(
            WSRButtonLabelModifier(
                bgColor: bgColor,
                fgColor: fgColor,
                font: font
            )
        )
    }
}

// MARK: - WSRDataFetcher Modifiers

public extension View {
    func wsr_ErrorAlertView(viewModel: WSRDataFetcher) -> some View {
        modifier(
            WSRErrorAlertViewModifier(viewModel: viewModel)
        )
    }
    
    func wsr_LoadingView(viewModel: WSRDataFetcher) -> some View {
        modifier(
            WSRLoadingViewModifier(viewModel: viewModel)
        )
    }
}
