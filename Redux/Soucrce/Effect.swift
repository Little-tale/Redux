//
//  Effect.swift
//  Redux
//
//  Created by Jae hyung Kim on 11/21/24.
//

import Foundation

struct Effect<Action>: @unchecked Sendable {
    let caseOf: EffectCase
    let taskID: _CancelID?

    
    init(caseOf: EffectCase, taskID: AnyHashable? = nil) {
        self.caseOf = caseOf
        if let taskID {
            self.taskID = _CancelID(id: taskID)
        } else {
            self.taskID = nil
        }
    }
    
    enum EffectCase: Sendable {
        case none
        case run(TaskPriority? = nil, @Sendable (_ send: @escaping (Action) async -> Void) async -> Void)
        case cancel
    }

    static var none: Self {
        return Self(caseOf: .none)
    }

    static func run(priority: TaskPriority? = nil, task: @escaping @Sendable (_ send: @escaping (Action) async -> Void) async -> Void) -> Self {
        return Self(caseOf: .run(priority, task))
    }
    
    static func cancel(id: some Hashable & Sendable) -> Self {
        return Self(caseOf: .cancel, taskID: id)
    }
    
    func cancelTask(id: some Hashable & Sendable) -> Self {
        switch caseOf {
        case .none:
            return .none
        case .run(let taskPriority, let action):
            return Self(caseOf: .run(taskPriority, action), taskID: id)
        case .cancel:
            return .none
        }
    }
}

