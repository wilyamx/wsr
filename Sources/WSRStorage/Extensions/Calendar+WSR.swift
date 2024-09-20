//
//  Calendar+WSR.swift
//  WSR
//
//  Created by William S. Rena on 9/20/24.
//

import Foundation

extension Calendar {
    static func getUTC() -> Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC") ?? TimeZone.autoupdatingCurrent
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar
    }

    static func getJST() -> Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Tokyo") ?? TimeZone.autoupdatingCurrent
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar
    }
}
