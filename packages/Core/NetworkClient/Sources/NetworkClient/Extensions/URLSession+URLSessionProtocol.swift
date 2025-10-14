// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation

/// Protocol that abstracts the core behavior of `URLSession` to enable dependency injection
/// and testing (for example, using mocked sessions).
///
/// `URLSession` conforms to this protocol directly so production code can use
/// real instances like `URLSession.shared`, while tests can provide custom implementations
/// that return controlled responses.
///
/// Example usage:
/// ```swift
/// struct APIClient {
///     let session: URLSessionProtocol
///
///     func fetch(_ request: URLRequest) async throws -> Data {
///         let (data, response) = try await session.data(for: request, delegate: nil)
///         guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
///             throw URLError(.badServerResponse)
///         }
///         return data
///     }
/// }
/// ```
public protocol URLSessionProtocol {
    /// Performs a network request and returns the response bytes along with the associated `URLResponse`.
    /// - Parameter request: The `URLRequest` to execute.
    /// - Parameter delegate: An optional delegate to receive events from the associated `URLSessionTask`.
    /// - Returns: A tuple containing the received `Data` and the corresponding `URLResponse`.
    /// - Throws: Propagates networking errors such as `URLError`.
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

