// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

/// Default implementation of `NetworkClient` using `URLSessionProtocol`.
import Foundation

/// A concrete `NetworkClient` that performs requests using a `URLSessionProtocol`.
///
/// `NetworkClientImpl` executes a request provided by a `URLRequestBuilder`,
/// returning the received `Data` and `HTTPURLResponse`. If the underlying
/// response is not an `HTTPURLResponse`, it throws `NetworkClientError.notHTTPResponse`.
/// If the request fails due to an offline network condition, it throws
/// `NetworkClientError.internetOffline`; otherwise, it propagates the original error.
public final class NetworkClientImpl: NetworkClient {
    /// The session used to execute network requests.
    private let session: URLSessionProtocol

    /// Creates a client with the given session.
    /// - Parameter session: The session to use. Defaults to `URLSession.shared`.
    public init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    /// Performs a network request using the given builder.
    ///
    /// - Parameter requestBuilder: An object that provides a configured `URLRequest`.
    /// - Returns: A tuple containing the received `Data` and `HTTPURLResponse`.
    /// - Throws: `NetworkClientError.notHTTPResponse` when the response is not HTTP,
    ///           `NetworkClientError.internetOffline` when there is no internet
    ///           connection, or any other error produced by the underlying session.
    public func request(
        with requestBuilder: URLRequestBuilder
    ) async throws -> (Data, HTTPURLResponse) {
        do {
            let (data, response) = try await session.data(for: requestBuilder.request, delegate: nil)
            guard
                let urlResponse = response as? HTTPURLResponse
            else {
                throw NetworkClientError.notHTTPResponse
            }
            return (data, urlResponse)
        } catch {
            throw error.isInternetOffline ? NetworkClientError.internetOffline : error
        }
    }
}
