//
//  ComposableTransparentAccountTests.swift
//  JioujiappTests
//
//  Created by Ladislav Žižka on 23.07.2022.
//

import ComposableArchitecture
import XCTest
@testable import Jioujiapp

class ComposableTransparentAccountTests: XCTestCase {
    func testComposableTransparentAccountTakesStates() {
        let state = TransparentAccountState(accounts: [ModelTransparentAccount]())
        XCTAssertNotNil(state.accounts)
    }

    func testComposableTransparentAccountTakesActions() {
        let action = TransparentAccountAction.self
        XCTAssertNotNil(action.onAppear)
        XCTAssertNotNil(action.dataLoaded)
    }

    func testComposableTransparentAccountTakesEnvironments() {
        func dummyEffect() -> Effect<[ModelTransparentAccount], ApiError> {
            let dummyJson = [ModelTransparentAccount]()
            return Effect(value: dummyJson)
        }
        let environment = TransparentAccountEnvironment(transparentAccountsRequest: dummyEffect)
        XCTAssertNotNil(environment.transparentAccountsRequest)
    }

    func testComposableTransparentAccountTakesReducer() {
        let testScheduler = DispatchQueue.test
        var transparentAccountDummy: [ModelTransparentAccount] {[
            ModelTransparentAccount(
                accountNumber: "Dummy",
                bankCode: "Dummy",
                transparencyFrom: "Dummy",
                transparencyTo: "Dummy",
                actualizationDate: "Dummy",
                balance: 0.0, currency: "Dummy",
                name: "Dummy",
                iban: "Dummy")
        ]}

        func dummyTransparentAccountEffect() -> Effect<[ModelTransparentAccount], ApiError> {
            return Effect(value: transparentAccountDummy)
        }

        let store = TestStore(
            initialState: TransparentAccountState(accounts: []),
            reducer: transparentAccountReducer,
            environment: SystemEnvironment(
                environment: TransparentAccountEnvironment(
                    transparentAccountsRequest: dummyTransparentAccountEffect),
                mainQueue: { testScheduler.eraseToAnyScheduler() }))
        store.send(.onAppear)
        testScheduler.advance()
        store.receive(.dataLoaded(.success(transparentAccountDummy))) { state in
            state.accounts = transparentAccountDummy
            XCTAssertEqual(state.accounts.first?.name, "Dummy")
            XCTAssertEqual(state.accounts.first?.balance, 0.0)
        }
    }
}
