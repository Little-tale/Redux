//
//  AnyValueActor.swift
//  Redux
//
//  Created by Jae hyung Kim on 11/22/24.
//

import Foundation

final actor AnyValueActor<Value> {
    private let defaultValue: Value
    private var value: Value
    
    init(_ value: @autoclosure @Sendable () throws -> Value) rethrows {
        self.defaultValue = try value()
        self.value = defaultValue
    }
}

extension AnyValueActor {
    
    @discardableResult
    func withValue<T: Sendable>(
        _ operation: @Sendable (inout Value) throws -> T
    ) rethrows -> T {
        var value = self.value
        defer { self.value = value }
        return try operation(&value)
    }
    
    func setValue(_ newValue: @autoclosure @Sendable () throws -> Value) rethrows {
        self.value = try newValue()
    }
    
    func resetValue() {
        value = defaultValue
    }
}
