//
//  WSRErrorAlertViewModifier.swift
//  WSR
//
//  Created by William S. Rena on 9/24/24.
//

import SwiftUI
import WSRNetworking

public struct WSRErrorAlertViewModifier: ViewModifier {
    @ObservedObject var viewModel: WSRDataFetcher
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            
            if viewModel.showErrorAlert {
                Color.black
                    .opacity(0.25)
                    .ignoresSafeArea()
                
                WSRErrorAlertView(
                    showErrorAlert: $viewModel.showErrorAlert,
                    errorAlertType: viewModel.errorAlertType,
                    closeErrorAlert: {
                        //logger.info(message: "Close!")
                    })
            }
        }
        
    }
}

