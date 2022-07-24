//
//  ComposableTransparentAccount.swift
//  Jioujiapp
//
//  Created by Ladislav Žižka on 23.07.2022.
//

import ComposableArchitecture

struct TransparentAccountState: Equatable {
    var accounts: [ModelTransparentAccount]
}

enum TransparentAccountAction: Equatable {
    case onAppear
    case dataLoaded(Result<[ModelTransparentAccount], ApiError>)
    case tap(ModelTransparentAccount)
}

struct TransparentAccountEnvironment {
    var transparentAccountsRequest: () -> Effect<[ModelTransparentAccount], ApiError>
}

let transparentAccountReducer = Reducer<
    TransparentAccountState,
    TransparentAccountAction,
    SystemEnvironment<TransparentAccountEnvironment>
> { state, action, environment in
    switch action {
    case .onAppear:
        return environment.transparentAccountsRequest()
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(TransparentAccountAction.dataLoaded)
    case .dataLoaded(let result):
        switch result {
        case .success(let accounts):
            state.accounts = accounts
        case .failure:
            state.accounts = []
        }
        return .none
    case .tap(let account):
        return .none
    }
}

