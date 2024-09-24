//
//  Task+WSR.swift
//  WSR
//
//  Created by William S. Rena on 9/12/24.
//

import Foundation

public extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: TimeInterval) async {
        try? await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
    }
}
