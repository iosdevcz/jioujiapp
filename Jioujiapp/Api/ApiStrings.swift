//
//  ApiStrings.swift
//  Jioujiapp
//
//  Created by Ladislav Žižka on 22.07.2022.
//

import Foundation

struct ApiStrings {
    static var transparentAccountsBaseUrl: String {
        "https://webapi.developers.erstegroup.com/api/csas/public/sandbox/v3/transparentAccounts"
    }
    
    static var transparentAccountsHeaderWebApiKey: String {
        "WEB-API-key"
    }

    enum HttpMethod: String {
        case get = "GET"
    }

    struct ContentType {
        static var name: String {
            "Content-Type"
        }

        static var value: String {
            "application/json"
        }
    }
}
