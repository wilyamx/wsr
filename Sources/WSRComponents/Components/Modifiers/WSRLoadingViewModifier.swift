//
//  WSRLoadingViewModifier.swift
//  WSR
//
//  Created by William S. Rena on 9/24/24.
//

import SwiftUI
import WSRNetworking

public struct WSRLoadingViewModifier: ViewModifier {
//    @ObservedObject var viewModel: WSRDataFetcher
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            
//            if viewModel.viewState == .loading {
//                Color.black
//                    .opacity(0.25)
//                    .ignoresSafeArea()
//                
//                WSRProcessingView(loadingMessage: viewModel.loadingMessage)
//            }
        }
        
    }
}

