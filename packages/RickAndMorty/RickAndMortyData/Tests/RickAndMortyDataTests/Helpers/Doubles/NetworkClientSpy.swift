// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import NetworkClient

final class NetworkClientSpy: NetworkClient {
    let data: Data
    var requestedUrlAbsoluteString: String?

    init(data: Data) {
        self.data = data
    }

    func request(with requestBuilder: any URLRequestBuilder) async throws -> (Data, HTTPURLResponse) {
        let url = requestBuilder.request.url!
        requestedUrlAbsoluteString = url.absoluteString
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        return (data, response)
    }
}
