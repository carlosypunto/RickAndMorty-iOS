// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
@testable import NetworkClient

final class MockURLSession: URLSessionProtocol {
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?
    var lastRequest: URLRequest?

    func data(
        for request: URLRequest,
        delegate: (any URLSessionTaskDelegate)?
    ) async throws -> (Data, URLResponse) {
        lastRequest = request
        if let error = error {
            throw error
        }

        guard
            let data = data,
            let urlResponse = urlResponse
        else {
            assertionFailure("Developer: you must set error or data and response")
            throw NSError(domain: "MockError", code: -1, userInfo: nil)
        }
        return (data, urlResponse)
    }
}
