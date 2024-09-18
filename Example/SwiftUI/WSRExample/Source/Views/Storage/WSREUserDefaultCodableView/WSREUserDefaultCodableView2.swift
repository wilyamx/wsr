//
//  WSREUserDefaultCodableView2.swift
//  WSRExample
//
//  Created by William S. Rena on 9/18/24.
//

import SwiftUI
import WSRStorage

/**
    BUG: Property wrapper does not work when put in View Model.
 */
struct WSREUserDefaultCodableView2: View {
    
    let viewModel = WSREUserDefaultCodableViewModel()
    
    var body: some View {
        VStack(spacing: 40) {
            Button(viewModel.user?.description ?? "NO-DEFAULT-DESCRIPTION") {
                viewModel.user = WSREUserModel(name: "RICKY", age: 100)
            }
            WSRECodableBindedView(user: viewModel.$user.projectedValue)
        }
    }
}

#Preview {
    WSREUserDefaultCodableView2()
}
