//
//  ModelTransparentAccount.swift
//  Jioujiapp
//
//  Created by Ladislav Žižka on 24.07.2022.
//

import Foundation

struct ModelTransparentAccount: Decodable, Equatable {
    let accountNumber: String
    let bankCode: String
    let transparencyFrom: String
    let transparencyTo: String
    let actualizationDate: String
    let balance: Double
    let currency: String?
    let name: String
    let iban: String
}

extension ModelTransparentAccount: Identifiable {
    var id: String { accountNumber + bankCode }
}
