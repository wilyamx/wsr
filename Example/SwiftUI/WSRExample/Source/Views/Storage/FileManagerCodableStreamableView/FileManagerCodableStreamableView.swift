//
//  FileManagerCodableStreamableView.swift
//  WSRExample
//
//  Created by William S. Rena on 9/18/24.
//

import SwiftUI
import WSRUtils

struct FileManagerCodableStreamableView: View {
    //@FileManagerCodableStreamableProperty("codable_stream") private var user
    @FileManagerCodableStreamableProperty(\.userProfile) private var user

    var body: some View {
        VStack(spacing: 40) {
            Button(user?.description ?? "DEFAULT-DESCRIPTION") {
                user = WSREUserModel(name: "Lorem", age: 3)
            }
            WSRECodableBindedView(user: $user.binding)
        }
        .onReceive($user.publisher) { newValue in
            wsrLogger.info(message: "onReceive: \(newValue)")
        }
        .task {
            for await newValue in $user.stream {
                wsrLogger.info(message: "task: \(newValue)")
            }
        }
    }
}

#Preview {
    FileManagerCodableStreamableView()
}
