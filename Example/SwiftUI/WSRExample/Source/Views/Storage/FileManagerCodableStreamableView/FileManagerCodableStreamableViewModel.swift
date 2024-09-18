//
//  FileManagerCodableStreamableViewModel.swift
//  WSRExample
//
//  Created by William S. Rena on 9/18/24.
//

import Foundation

final class FileManagerCodableStreamableViewModel: ObservableObject {
    @FileManagerCodableStreamableProperty(\.userProfile) var user
}
