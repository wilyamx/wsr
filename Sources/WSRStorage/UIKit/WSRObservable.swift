//
//  WSRObservable.swift
//
//
//  Created by William S. Rena on 9/18/24.
//

import Foundation

public class WSRObservable<Value>: NSObject {
    private let notificationName: Notification.Name
    private let defaultValue: Value

    public init(notificationName: Notification.Name, default: Value) {
        self.notificationName = notificationName
        defaultValue = `default`
        super.init()
    }

    public func subscribe(onChange: @escaping (Value, Value?) -> Void) -> NSObjectProtocol {
        NotificationCenter.default.addObserver(
            forName: notificationName,
            object: nil,
            queue: nil,
            using: {
                let newValue = $0.object as? Value ?? self.defaultValue
                let oldValue = $0.userInfo?["old"] as? Value
                onChange(newValue, oldValue)
            }
        )
    }
}
