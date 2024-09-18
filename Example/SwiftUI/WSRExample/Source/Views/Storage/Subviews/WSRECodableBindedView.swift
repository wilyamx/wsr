//
//  WSRECodableBindedView.swift
//  WSRExample
//
//  Created by William S. Rena on 9/18/24.
//

import SwiftUI

struct WSRECodableBindedView: View {
    @Binding var userProfile: User?
    
    var body: some View {
        VStack {
            Text("Binded View (Nick)")
            Button(userProfile?.description ?? "NO DATA BINDED VIEW") {
                userProfile = User(name: "NICK", age: 123)
            }
        }
    }
}

#Preview {
    WSRECodableBindedView(userProfile: .constant(User(name: "Lorem", age: 1)))
}
