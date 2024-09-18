//
//  WSREStorageView.swift
//  WSRExample
//
//  Created by William S. Rena on 9/18/24.
//

import SwiftUI

struct User: Codable {
    let name: String
    let age: Int
    
    var description: String {
        return "\(name) at \(age)"
    }
}

struct WSREStorageView: View {
    //@FileManagerCodableProperty("user_profile") private var userProfile: User?
    @WSRUserDefaultCodable("user_profile2") private var user: User?
    
    let viewModel = WSREStorageViewModel()
    
    var body: some View {
        VStack(spacing: 40) {
            Button(user?.description ?? "NO-DATA-1") {
                user = User(name: "RICKY", age: 100)
            }
            WSRECodableBindedView(user: $user)
        }
        .onAppear {
            user = User(name: "DEFAULT-USER", age: 200)
        }
    }
}

#Preview {
    WSREStorageView()
}
