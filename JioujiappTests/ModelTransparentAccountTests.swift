//
//  ModelTransparentAccountTests.swift
//  JioujiappTests
//
//  Created by Ladislav Žižka on 24.07.2022.
//

import XCTest
@testable import Jioujiapp

class ModelTransparentAccountTests: XCTest {
    func testModelTransparentAccountInitTakesProperties() {
        let account = ModelTransparentAccount(
            accountNumber: "Dummy",
            bankCode: "Dummy",
            transparencyFrom: "Dummy",
            transparencyTo: "Dummy",
            actualizationDate: "Dummy",
            balance: 0.0,
            currency: nil,
            name: "Dummy",
            iban: "Dummy")
        XCTAssertNotNil(account.accountNumber)
        XCTAssertNotNil(account.bankCode)
        XCTAssertNotNil(account.transparencyFrom)
        XCTAssertNotNil(account.transparencyTo)
        XCTAssertNotNil(account.actualizationDate)
        XCTAssertNotNil(account.balance)
        XCTAssertNil(account.currency)
        XCTAssertNotNil(account.name)
        XCTAssertNotNil(account.iban)
    }
}
