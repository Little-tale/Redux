//
//  ContentView.swift
//  Redux
//
//  Created by Jae hyung Kim on 11/21/24.
//

import SwiftUI

struct ContentView: View {
   
    @StateObject var store: StoreOf<TestFeature> = Store(state: TestFeature.State(), reducer: TestFeature())
    
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

#Preview {
    ContentView()
}
