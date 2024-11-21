//
//  Feature.swift
//  Redux
//
//  Created by Jae hyung Kim on 11/21/24.
//

import Foundation

struct TestFeature: Reducer {
    
    struct State {
        var title = "1"
    }
    
    enum Action {
        case plus
        case task
        
        case failure(Error)
    }
    
    func reduce(_ state: inout State, with action: Action) -> Effect<Action> {
        switch action {
        case .plus:
            if let num = Int(state.title) {
                let next = num + 1
                state.title = String(next)
            }
            return .none
            
        case .task:
            return .run(priority: .high) { send in
                do {
                    try await Task.sleep(for: .seconds(2))
                    await send(.plus)
                } catch {
                    await send(.failure(error))
                }
            }
            
        case .failure(let error):
            print(error)
            return .none
        }
    }
}
