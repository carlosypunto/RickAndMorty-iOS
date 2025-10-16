// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Testing
import NetworkClient
import RickAndMortyDomain
@testable import RickAndMortyServices

struct RepositoryErrorMappingTests {
    @Test func test_map() async throws {
        let msg = "\(Int.random(in: 1000000000000...9999999999999))"
        let randomStatusCode = Int.random(in: 500...1000)
        #expect(RepositoryError.map(from: ServiceError.invalidParameter(msg)) == .invalidParameter(msg))
        #expect(RepositoryError.map(from: ServiceError.offline) == .offline)
        #expect(RepositoryError.map(from: ServiceError.decodeError) == .decode)
        #expect(RepositoryError.map(from: ServiceError.notHTTPResponse) == .server)
        #expect(RepositoryError.map(from: ServiceError.notSuccessfulResponse(statusCode: 401)) == .unauthorized)
        #expect(RepositoryError.map(from: ServiceError.notSuccessfulResponse(statusCode: 403)) == .unauthorized)
        #expect(RepositoryError.map(from: ServiceError.notSuccessfulResponse(statusCode: 404)) == .notFound)
        #expect(RepositoryError.map(from: ServiceError.notSuccessfulResponse(statusCode: 429)) == .rateLimited(retryAfter: nil))
        #expect(RepositoryError.map(from: ServiceError.notSuccessfulResponse(statusCode: randomStatusCode)) == .server)
        #expect(RepositoryError.map(from: ServiceError.notSuccessfulResponse(statusCode: -1009)) == .unknown)
        #expect(RepositoryError.map(from: ServiceError.unknown) == .unknown)
    }
}
