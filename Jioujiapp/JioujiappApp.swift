//
//  JioujiappApp.swift
//  Jioujiapp
//
//  Created by Ladislav Žižka on 21.07.2022.
//

import ComposableArchitecture
import SwiftUI

@main
struct JioujiappApp: App {
    var body: some Scene {
        WindowGroup {
            ViewMain(
                store: Store(
                    initialState: MainState(),
                    reducer: mainReducer,
                    environment: .sandbox(environment: MainEnvironment())))
        }
    }
}
