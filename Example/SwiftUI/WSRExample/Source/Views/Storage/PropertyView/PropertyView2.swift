//
//  PropertyView2.swift
//  WSRExample
//
//  Created by William S. Rena on 9/19/24.
//

import SwiftUI
import Combine
import WSRUtils

struct PropertyView2: View {
    @ObservedObject var viewModel = PropertyViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text(viewModel.message)
            WSREBindedView(message: viewModel.$message)
            Button {
                viewModel.message = "Samurai"
                viewModel.count = 1
            } label: {
                Text("Try Me")
            }
        }
        .onReceive(viewModel.$count, perform: { newValue in
            wsrLogger.info(message: "Count Value: \(newValue)")
        })
//        .onReceive(viewModel.$message, perform: { newValue in
//            wsrLogger.info(message: "Message Value: \(newValue)")
//        })
        //example.objectWillChange.sink { () in print("objectWillChange") }.store(in: &cancellables)
        
        /*
        CatApiService().getCatBreedsUsingCombineMocked(urlString: urlString)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    logger.error(message: error.localizedDescription)
                    break
                }
            } receiveValue: { cats in
                logger.api(message: "cats: \(cats.count)")
            }
            .store(in: &cancellables)
        */
    }
}

#Preview {
    PropertyView2()
}
