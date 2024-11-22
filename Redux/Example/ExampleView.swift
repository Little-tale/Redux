//
//  ExampleView.swift
//  Redux
//
//  Created by Jae hyung Kim on 11/22/24.
//

import SwiftUI

struct ExampleView: View {
    
    @StateObject var store: StoreOf<TestFeature>
    
    var body: some View {
        VStack {
            Text(store.state.title)
            Button("+") {
                store.send(.plus)
            }
            Button("+ 2sec Delay") {
                store.send(.task)
            }
        }
        .padding()
    }
}
