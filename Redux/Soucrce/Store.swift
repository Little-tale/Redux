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
            Task(priority: priority) {
                await task { [weak self] newAction in
                    self?.send(newAction)
                }
            }
        }
    }
}
