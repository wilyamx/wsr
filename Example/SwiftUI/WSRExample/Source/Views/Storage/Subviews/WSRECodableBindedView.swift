//
//  WSRECodableBindedView.swift
//  WSRExample
//
//  Created by William S. Rena on 9/18/24.
//

import SwiftUI

struct WSRECodableBindedView: View {
    @Binding var user: User?
    
    var body: some View {
        VStack {
            Text("Binded View (Nick)")
            Button(user?.description ?? "NO DATA BINDED VIEW") {
                user = User(name: "NICK", age: 123)
            }
        }
    }
}

#Preview {
    WSRECodableBindedView(user: .constant(User(name: "Lorem", age: 1)))
}
