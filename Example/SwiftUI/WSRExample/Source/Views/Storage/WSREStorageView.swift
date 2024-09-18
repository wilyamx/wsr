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
}

struct WSREStorageView: View {
    @FileManagerCodableProperty("user_profile") private var userProfile: User?
    
    let viewModel = WSREStorageViewModel()
    
    var body: some View {
        VStack(spacing: 40) {
            Button(userProfile?.name ?? "no value") {
                userProfile = User(name: "RICKY", age: 11111)
            }
            SomeBindingView(userProfile: $userProfile)
        }
    }
}

struct SomeBindingView: View {
    @Binding var userProfile: User?
    
    var body: some View {
        VStack {
            Text("Binding View")
            Button(userProfile?.name ?? "no value") {
                userProfile = User(name: "NICK", age: 1013451324513450)
            }
        }
    }
}

#Preview {
    WSREStorageView()
}
