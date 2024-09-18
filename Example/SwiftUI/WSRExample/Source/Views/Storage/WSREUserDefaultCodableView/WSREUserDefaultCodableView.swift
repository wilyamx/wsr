//
//  WSREUserDefaultCodableView.swift
//  WSRExample
//
//  Created by William S. Rena on 9/18/24.
//

import SwiftUI
import WSRStorage

struct WSREUserDefaultCodableView: View {
    @WSRUserDefaultCodable("user_codable") private var user: WSREUserModel?
    
    var body: some View {
        VStack(spacing: 40) {
            Button(user?.description ?? "NO-DEFAULT-DESCRIPTION") {
                user = WSREUserModel(name: "RICKY", age: 100)
            }
            WSRECodableBindedView(user: $user)
        }
    }
}

#Preview {
    WSREUserDefaultCodableView()
}
