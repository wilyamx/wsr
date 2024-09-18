//
//  PropertyView.swift
//  WSRExample
//
//  Created by William S. Rena on 9/19/24.
//

import SwiftUI

struct PropertyView: View {
    @UppercaseProperty private var message: String = "anime"
    
    var body: some View {
        VStack(spacing: 20) {
            Text(message)
            WSREBindedView(message: $message)
            Button {
                message = "Samurai"
            } label: {
                Text("Try Me")
            }

        }
    }
}

#Preview {
    PropertyView()
}
