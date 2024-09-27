//
//  File.swift
//  
//
//  Created by William S. Rena on 9/27/24.
//

import Foundation

public extension Task where Success == Never, Failure == Never {
    /**
        await Task.sleep(seconds: 3.0)
     */
    static func sleep(seconds: TimeInterval) async {
        try? await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
    }
}
