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
    @WSRUserDefaultCodable("user_profile2") private var userProfile: User?
    
    let viewModel = WSREStorageViewModel()
    
    var body: some View {
        VStack(spacing: 40) {
            Button(userProfile?.description ?? "NO-DATA-1") {
                userProfile = User(name: "RICKY", age: 100)
            }
            WSRECodableBindedView(userProfile: $userProfile)
        }
        .onAppear {
            userProfile = User(name: "NO-NAME-1", age: 200)
        }
    }
}

#Preview {
    WSREStorageView()
}
