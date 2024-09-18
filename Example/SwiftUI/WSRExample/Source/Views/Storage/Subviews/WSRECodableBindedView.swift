//
//  WSRECodableBindedView.swift
//  WSRExample
//
//  Created by William S. Rena on 9/18/24.
//

import SwiftUI

struct WSRECodableBindedView: View {
    @Binding var user: WSREUserModel?
    
    var body: some View {
        VStack {
            Text("Binded View (Nick)")
            Button(user?.description ?? "NO-DEFAULT-DESCRIPTION") {
                user = WSREUserModel(name: "NICK", age: 123)
            }
        }
    }
}

#Preview {
    WSRECodableBindedView(user: .constant(WSREUserModel(name: "Lorem", age: 1)))
}
