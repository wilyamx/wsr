//
//  WSRProjectedValue.swift
//  WSR
//
//  Created by William S. Rena on 9/17/24.
//

import Foundation
import Combine
import SwiftUI

public struct WSRProjectedValue<T: Codable> {
    public let binding: Binding<T?>
    public let publisher: CurrentValueSubject<T?, Never>
    
    public var stream: AsyncPublisher<CurrentValueSubject<T?, Never>> {
        publisher.values
    }
    
    public init(binding: Binding<T?>, publisher: CurrentValueSubject<T?, Never>) {
        self.binding = binding
        self.publisher = publisher
    }
}
