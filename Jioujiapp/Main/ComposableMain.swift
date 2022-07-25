//
//  ComposableMain.swift
//  Jioujiapp
//
//  Created by Ladislav Žižka on 24.07.2022.
//

import ComposableArchitecture

struct MainState {
    var transparentAccountState = TransparentAccountState(accounts: [])
}

enum MainAction {
    case transparentAccountAction(TransparentAccountAction)
}

struct MainEnvironment { }

let mainReducer = Reducer<
    MainState,
    MainAction,
    SystemEnvironment<MainEnvironment>
>.combine(
    transparentAccountReducer.pullback(
        state: \.transparentAccountState,
        action: /MainAction.transparentAccountAction,
        environment: { _ in .sandbox(
            environment: TransparentAccountEnvironment(
                transparentAccountsRequest: transparentAccountsApiRequestEffect))}))
