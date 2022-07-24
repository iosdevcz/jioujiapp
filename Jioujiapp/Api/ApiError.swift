//
//  ApiError.swift
//  Jioujiapp
//
//  Created by Ladislav Žižka on 22.07.2022.
//

import Foundation

enum ApiError: Error {
    case decodingError
    case malformedUrl
    case noApiKey
    case serverError
}
