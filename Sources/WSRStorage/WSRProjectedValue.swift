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
    let binding: Binding<T?>
    let publisher: CurrentValueSubject<T?, Never>
    
    var stream: AsyncPublisher<CurrentValueSubject<T?, Never>> {
        publisher.values
    }
    
    public init(binding: Binding<T?>, publisher: CurrentValueSubject<T?, Never>) {
        self.binding = binding
        self.publisher = publisher
    }
}
