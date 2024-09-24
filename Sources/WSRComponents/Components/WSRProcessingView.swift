//
//  WSRProcessingView.swift
//  WSR
//
//  Created by William S. Rena on 9/24/24.
//

import SwiftUI

public struct WSRProcessingView: View {
    let gradientColor = LinearGradient(
        gradient: Gradient(colors: [.green, .black]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    @State var loadingMessage: String = "Loading"
    
    public var body: some View {
        VStack {
            VStack {
                Image(systemName: "eyes")
                    .font(.system(size: 50, weight: .bold))
                    .foregroundColor(.black)
                
                Text("Lorem ipsum")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.yellow)
                
                Text("Dolor")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .tracking(10)
                
                ProgressView(){
                    Text(loadingMessage)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.orange)
                        .font(.title2)
                        .bold()
                }
                    .tint(.white)
                    .controlSize(.large)
                    .padding()
            }
        }
        .padding(40)
        .background(gradientColor).opacity(0.95)
        .cornerRadius(20)
    }
}

struct WSRProcessingView_Previews: PreviewProvider {
    static var previews: some View {
        WSRProcessingView(loadingMessage: "Processing")
    }
}
