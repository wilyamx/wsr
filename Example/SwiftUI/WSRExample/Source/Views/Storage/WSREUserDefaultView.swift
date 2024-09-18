//
//  WSREUserDefaultView.swift
//  WSRExample
//
//  Created by William S. Rena on 9/18/24.
//

import SwiftUI
import WSRStorage

struct WSREUserDefaultView: View {
    @WSRUserDefault("version_number", defaultValue: 100) private var version
    
    var body: some View {
        VStack(spacing: 40) {
            Button("Version \(version)") {
                //version = 54
            }
            //WSRECodableBindedView(user: $user)
        }
    }
}

#Preview {
    WSREUserDefaultView()
}
