//
//  Effect.swift
//  Redux
//
//  Created by Jae hyung Kim on 11/21/24.
//

import Foundation

struct Effect<Action>: Sendable {
    let caseOf: EffectCase

    enum EffectCase: Sendable {
        case none
        case run(TaskPriority? = nil, @Sendable (_ send: @escaping (Action) async -> Void) async -> Void)
    }

    static var none: Self {
        return Self(caseOf: .none)
    }

    static func run(priority: TaskPriority? = nil, task: @escaping @Sendable (_ send: @escaping (Action) async -> Void) async -> Void) -> Self {
        return Self(caseOf: .run(priority, task))
    }
}

