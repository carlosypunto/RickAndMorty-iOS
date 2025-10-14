// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
@testable import NetworkClient

struct DummyURLRequestBuilder: URLRequestBuilder {
    let dummyRequest: URLRequest
    var request: URLRequest { dummyRequest }

    init(url: URL) {
        dummyRequest = URLRequest(url: url)
    }

    func setPath(_ path: String) -> RequestBuilder {
        fatalError("Not required in tests")
    }

    func setQueryItems(_ items: [URLQueryItem]) -> RequestBuilder {
        fatalError("Not required in tests")
    }

    func addQueryItem(name: String, value: String?) -> RequestBuilder {
        fatalError("Not required in tests")
    }

}
