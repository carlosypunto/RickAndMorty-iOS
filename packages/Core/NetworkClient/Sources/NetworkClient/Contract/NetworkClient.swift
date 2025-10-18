// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation

/// Protocol that defines a minimal HTTP client abstraction responsible for executing requests
/// built by a `URLRequestBuilder` and returning raw response data.
///
/// This protocol enables dependency injection and easier testing by decoupling higher-level
/// networking logic from concrete transport implementations (e.g., `URLSession`).
public protocol NetworkClient: Sendable {
    /// Executes a request built by the provided `URLRequestBuilder`.
    /// - Parameter requestBuilder: A builder responsible for producing a configured `URLRequest`.
    /// - Returns: A tuple containing the response `Data` and the associated `HTTPURLResponse`.
    /// - Throws: Any transport or decoding errors encountered during the request lifecycle, such as `URLError`.
    func request(with requestBuilder: URLRequestBuilder) async throws -> (Data, HTTPURLResponse)
}
