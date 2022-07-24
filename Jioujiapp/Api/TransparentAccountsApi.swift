//
//  TransparentAccountsApi.swift
//  Jioujiapp
//
//  Created by Ladislav Žižka on 22.07.2022.
//

import Foundation

struct TransparentAccountsApi {
    private let apiUrlString: String
    private let environmentVariableApiKey: String

    var baseUrl: URL {
        get throws {
            guard let url = URL(string: apiUrlString) else {
                throw ApiError.malformedUrl }
            return url
        }
    }

    var headerField: String {
        ApiStrings.transparentAccountsHeaderWebApiKey
    }

    var apiKey: String {
        get throws {
            guard let apiKey = ProcessInfo.processInfo.environment[environmentVariableApiKey] else {
                throw ApiError.noApiKey }
            return apiKey
        }
    }

    init(apiUrlString: String, environmentVariableApiKey: String) {
        self.apiUrlString = apiUrlString
        self.environmentVariableApiKey = environmentVariableApiKey
    }
}

extension TransparentAccountsApi {
    struct Json: Decodable {
        let accounts: [ModelTransparentAccount]
    }
}
