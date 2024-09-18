//
//  FileManagerCodableStreamableView2.swift
//  WSRExample
//
//  Created by William S. Rena on 9/18/24.
//

import SwiftUI

struct FileManagerCodableStreamableView2: View {
    let viewModel = FileManagerCodableStreamableViewModel()
    
    var body: some View {
        VStack(spacing: 40) {
            Button(viewModel.user?.description ?? "DEFAULT-DESCRIPTION") {
                viewModel.user = WSREUserModel(name: "Lorem", age: 3)
            }
            WSRECodableBindedView(user: viewModel.$user.binding)
        }
    }
}

#Preview {
    FileManagerCodableStreamableView2()
}
