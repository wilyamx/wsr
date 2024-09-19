//
//  WSREBindedView.swift
//  WSRExample
//
//  Created by William S. Rena on 9/18/24.
//

import SwiftUI

struct WSREBindedView: View {
    @Binding var message: String?
    
    var body: some View {
        VStack {
            Text("Binded View")
            Button {
                message = "another message!"
            } label: {
                Text(message ?? "")
            }
        }
    }
}

#Preview {
    WSREBindedView(message: .constant("DEFAULT-MESSAGE"))
}
