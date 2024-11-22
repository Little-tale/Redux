//
//  ReduxApp.swift
//  Redux
//
//  Created by Jae hyung Kim on 11/21/24.
//

import SwiftUI

@main
struct ReduxApp: App {
    var body: some Scene {
        WindowGroup {
            ExampleView(store: Store(state: TestFeature.State(), reducer: TestFeature()))
        }
    }
}
