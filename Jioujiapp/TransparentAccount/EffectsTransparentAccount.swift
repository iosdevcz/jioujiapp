//
//  EffectsTransparentAccount.swift
//  Jioujiapp
//
//  Created by Ladislav Žižka on 23.07.2022.
//

import ComposableArchitecture

func transparentAccountsApiRequestEffect() -> Effect<[ModelTransparentAccount], ApiError> {
    let api = TransparentAccountsApi(apiUrlString: ApiStrings.transparentAccountsBaseUrl,
                                     environmentVariableApiKey: EnvironmentVariable.transparentAccountsApiKey)
    let url: URL
    let apiKey: String

    do {
        url = try api.baseUrl
        apiKey = try api.apiKey
    } catch ApiError.malformedUrl {
        fatalError("Url has wrong format.")
    } catch ApiError.noApiKey {
        fatalError("Api key is missing, please add api key to environment variable specified in EnvironmentVariable.swift.")
    } catch {
        fatalError()
    }

    var apiRequest = URLRequest(url: url)
    apiRequest.httpMethod = ApiStrings.HttpMethod.get.rawValue
    apiRequest.setValue(ApiStrings.ContentType.value, forHTTPHeaderField: ApiStrings.ContentType.name)
    apiRequest.setValue(apiKey, forHTTPHeaderField: api.headerField)

    return URLSession.shared.dataTaskPublisher(for: apiRequest)
        .mapError { _ in ApiError.serverError }
        .map { $0.data }
        .decode(type: TransparentAccountsApi.Json.self, decoder: JSONDecoder())
        .mapError { _ in ApiError.decodingError }
        .map { $0.accounts }
        .eraseToEffect()
}
