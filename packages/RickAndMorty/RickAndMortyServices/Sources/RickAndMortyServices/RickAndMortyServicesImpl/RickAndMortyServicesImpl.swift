// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import NetworkClient

public final class RickAndMortyServicesImpl: RickAndMortyServices {
    let baseURL = URL(string: "https://rickandmortyapi.com/api")!
    let networkClient: NetworkClient

    public init(networkClient: NetworkClient = NetworkClientImpl()) {
        self.networkClient = networkClient
    }
}
