//
//  Date+WSR.swift
//  WSR
//
//  Created by William S. Rena on 9/20/24.
//

import Foundation
import UIKit

public extension Date {
    init?(iso8601 string: String) {
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: string) else { return nil }
        self = date
    }
    
    init(year: Int, month: Int, day: Int,
         hour: Int? = nil, minute: Int? = nil, second: Int? = nil, nanoSecond: Int? = nil) {
        let calendar = Calendar.getJST()
        var comps = DateComponents()
        comps.year = year
        comps.month = month
        comps.day = day
        comps.hour = hour
        comps.minute = minute
        comps.second = second
        comps.nanosecond = nanoSecond
        self = calendar.date(from: comps)!
    }
    
    var toIso8601: String {
        ISO8601DateFormatter().string(from: self)
    }
}
