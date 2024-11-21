//
//  Reducer.swift
//  Redux
//
//  Created by Jae hyung Kim on 11/21/24.
//

import Foundation

protocol Reducer<State, Action> {
    associatedtype State
    associatedtype Action
    
    func reduce(_ state: inout State, with action: Action) -> Effect<Action>
}

