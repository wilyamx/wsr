//
//  WSREStorageViewModel.swift
//  WSRExample
//
//  Created by William S. Rena on 9/18/24.
//

import SwiftUI
import WSRStorage

final class WSREUserDefaultCodableViewModel: ObservableObject {
    @WSRUserDefaultCodable("user") var user: WSREUserModel?
}
