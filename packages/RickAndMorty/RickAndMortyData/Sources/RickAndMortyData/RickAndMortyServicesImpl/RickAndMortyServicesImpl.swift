// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import NetworkClient

final class RickAndMortyServicesImpl: RickAndMortyServices {
    let baseURL = URL(string: "https://rickandmortyapi.com/api")!
    let networkClient: NetworkClient
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .customWithISO8601Formatter
        return decoder
    }()

    init(networkClient: NetworkClient = NetworkClientImpl()) {
        self.networkClient = networkClient
    }

    func decode<T>(_ type: T.Type, from data: Data) throws(ServiceError) -> T where T : Decodable {
        do {
            return try decoder.decode(type.self, from: data)
        } catch {
            throw ServiceError.decodeError
        }
    }
}
