//
//  TransparentAccountsApiTests.swift
//  JioujiappTests
//
//  Created by Ladislav Žižka on 22.07.2022.
//

import XCTest
@testable import Jioujiapp

class TransparentAccountsApiTests: XCTestCase {

    func testUrlIsMalformed() {
        let api = TransparentAccountsApi(apiUrlString: "", environmentVariableApiKey: "")
        XCTAssertThrowsError(try api.baseUrl)
    }

    func testUrlIsOk() {
        let api = TransparentAccountsApi(apiUrlString: ApiStrings.transparentAccountsBaseUrl,
                                         environmentVariableApiKey: "")
        XCTAssertNoThrow(try api.baseUrl)
    }

    func testTransparentAccountApiTakesHeaderField() {
        let api = TransparentAccountsApi(apiUrlString: "", environmentVariableApiKey: "")
        XCTAssertNotNil(api.headerField)
    }

    func testApiKeyIsMissing() {
        let api = TransparentAccountsApi(apiUrlString: "", environmentVariableApiKey: "")
        XCTAssertThrowsError(try api.apiKey)
    }

    func testApiKeyIsOk() {
        let api = TransparentAccountsApi(apiUrlString: "",
                                         environmentVariableApiKey: EnvironmentVariable.transparentAccountsApiKey)
        XCTAssertNoThrow(try api.apiKey)
    }

    func testJsonInitTakesAccounts() {
        let json = TransparentAccountsApi.Json(accounts: [])
        XCTAssertNotNil(json)
    }

    func testIsJsonDecodable() throws {
        let dummyJson = """
            {
              "pageNumber": 0,
              "pageSize": 50,
              "pageCount": 8,
              "nextPage": 1,
              "recordCount": 375,
              "accounts": [
                {
                  "accountNumber": "000000-0109213309",
                  "bankCode": "0800",
                  "transparencyFrom": "2015-01-24T00:00:00",
                  "transparencyTo": "3000-01-01T00:00:00",
                  "publicationTo": "3000-01-01T00:00:00",
                  "actualizationDate": "2018-01-17T13:00:00",
                  "balance": 165939.97,
                  "currency": "CZK",
                  "name": "Společenství Praha 4, Obětí 6.května 553",
                  "iban": "CZ75 0800 0000 0001 0921 3309"
                }
              ]
            }
        """.data(using: .utf8)!

        let data = try JSONDecoder().decode(TransparentAccountsApi.Json.self, from: dummyJson)
        XCTAssertFalse(data.accounts.isEmpty)
        XCTAssertEqual(data.accounts.first!.accountNumber, "000000-0109213309")
        XCTAssertEqual(data.accounts.first!.balance, 165939.97)
    }
}
