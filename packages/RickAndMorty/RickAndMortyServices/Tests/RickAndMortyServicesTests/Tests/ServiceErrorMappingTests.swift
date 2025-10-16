// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Testing
import NetworkClient
@testable import RickAndMortyServices

struct ServiceErrorMappingTests {

    @Test func test_map() async throws {
        #expect(ServiceError.map(from: NetworkClientError.notHTTPResponse) == .notHTTPResponse)
        #expect(ServiceError.map(from: NetworkClientError.internetOffline) == .offline)
    }

}
