//
//  ComposableMainTests.swift
//  JioujiappTests
//
//  Created by Ladislav Žižka on 24.07.2022.
//

import ComposableArchitecture
import XCTest
@testable import Jioujiapp

class ComposableMainTests: XCTestCase {
    func testComposableMainTakesStates() {
        let state = MainState()
        XCTAssertNotNil(state.transparentAccountState)
    }
    
    func testComposableMainTakesActions() {
        let action = MainAction.self
        XCTAssertNotNil(action.transparentAccountAction)
    }
    
    func testComposableMainTakesEnvironmentsButEmpty() {
        let environment = MainEnvironment()
        XCTAssertNotNil(environment)
    }
}
