// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import NetworkClient

final class NetworkClientErrorSpy: NetworkClient {
    private let statusCode: Int
    var requestedUrlAbsoluteString: String?

    init(statusCode: Int = 500) {
        self.statusCode = statusCode
    }

    func request(with requestBuilder: any URLRequestBuilder) async throws -> (Data, HTTPURLResponse) {
        let url = requestBuilder.request.url!
        requestedUrlAbsoluteString = url.absoluteString
        let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
        return (Data(), response)
    }
}
