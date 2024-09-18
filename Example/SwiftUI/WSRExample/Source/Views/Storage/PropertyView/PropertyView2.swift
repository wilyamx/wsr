//
//  PropertyView2.swift
//  WSRExample
//
//  Created by William S. Rena on 9/19/24.
//

import SwiftUI

struct PropertyView2: View {
    let viewModel = PropertyViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text(viewModel.message)
            WSREBindedView(message: viewModel.$message)
            Button {
                viewModel.message = "Samurai"
            } label: {
                Text("Try Me")
            }

        }
    }
}

#Preview {
    PropertyView2()
}
