//
//  FileManagerCodableStreamableView2.swift
//  WSRExample
//
//  Created by William S. Rena on 9/18/24.
//

import SwiftUI
import WSRUtils

struct FileManagerCodableStreamableView2: View {
    let viewModel = FileManagerCodableStreamableViewModel()
    
    var body: some View {
        VStack(spacing: 40) {
            Button(viewModel.user?.description ?? "DEFAULT-DESCRIPTION") {
                viewModel.user = WSREUserModel(name: "Lorem", age: 4)
            }
            WSRECodableBindedView(user: viewModel.$user.binding)
        }
        .onReceive(viewModel.$user.publisher) { newValue in
            wsrLogger.info(message: "onReceive: \(newValue)")
        }
        .task {
            for await newValue in viewModel.$user.stream {
                wsrLogger.info(message: "task: \(newValue)")
            }
        }
    }
}

#Preview {
    FileManagerCodableStreamableView2()
}
