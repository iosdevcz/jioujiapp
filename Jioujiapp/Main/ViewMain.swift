//
//  ViewMain.swift
//  Jioujiapp
//
//  Created by Ladislav Žižka on 21.07.2022.
//

import ComposableArchitecture
import SwiftUI

struct ViewMain: View {
    let store: Store<MainState, MainAction>
    var body: some View {
        WithViewStore(self.store.stateless) { _ in
            TabView {
                ViewListTransparentAccounts(
                    store: store.scope(
                        state: \.transparentAccountState,
                        action: MainAction.transparentAccountAction))
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Accounts")
                }

                ViewAbout()
                    .tabItem {
                        Image(systemName: "info.circle")
                        Text("About")
                    }
            }
            .accentColor(Color.mint)
        }
    }
}

struct ViewAbout: View {
    var body: some View {
        Text("ジョージapp!")
            .padding()
    }
}

struct ViewMain_Previews: PreviewProvider {
    static var previews: some View {
        let mainView = ViewMain(
            store: Store(
                initialState: MainState(),
                reducer: mainReducer,
                environment: .preview(environment: MainEnvironment())))
        return mainView
    }
}
