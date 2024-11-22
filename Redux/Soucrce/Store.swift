//
//  Store.swift
//  Redux
//
//  Created by Jae hyung Kim on 11/21/24.
//

import Foundation

typealias StoreOf<R: Reducer> = Store<R.State, R.Action>

@MainActor
final class Store<State, Action>: ObservableObject {
    @Published private(set) var state: State
    private let reducer: any Reducer<State, Action>
    private let taskMap = AnyValueActor< [_CancelID : Task<Void, Never>]> ([:])

    
    init(state: State, reducer: any Reducer<State, Action>) {
        self.state = state
        self.reducer = reducer
    }
    
    func send(_ action: Action) {
        let effect = reducer.reduce(&state, with: action)
        handleEffect(effect)
    }
}

extension Store {
    private func handleEffect(_ effect: Effect<Action>) {
        
        if case let .run(priority, task) = effect.caseOf {
            let taskSToStore = Task(priority: priority) {
                await task { [weak self] newAction in
                    self?.send(newAction)
                }
            }
            
            if let taskID = effect.taskID {
                Task {
                    await taskMap.withValue { value in
                        value[taskID] = taskSToStore
                    }
                }
            }
        }
        
        if case .cancel = effect.caseOf {
            Task {
                await taskMap.withValue { value in
                    let taskId = effect.taskID
                    if let taskId {
                        
                        value.forEach { task in
                            if task.key.id == taskId.id {
                                print(value)
                                task.value.cancel()
                            }
                        }
                    }
                }
            }
        }
    }
}
