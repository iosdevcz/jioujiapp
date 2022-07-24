//
//  MainView.swift
//  Jioujiapp
//
//  Created by Ladislav Žižka on 21.07.2022.
//

import ComposableArchitecture
import SwiftUI

struct MainView: View {
    let store: Store<MainState, MainAction>
    var body: some View {
        WithViewStore(self.store.stateless) { _ in
            Text("ジョージapp!")
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let mainView = MainView(
            store: Store(
                initialState: MainState(),
                reducer: mainReducer,
                environment: .sandbox(environment: MainEnvironment())))
        return mainView
    }
}
