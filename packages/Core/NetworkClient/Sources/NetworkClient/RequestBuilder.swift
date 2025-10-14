// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation

/// A builder type to progressively construct URL requests from a base URL.

/// A concrete builder for creating `URLRequest` instances from a base URL.
///
/// Use `RequestBuilder` to progressively configure request components starting
/// from a `base` URL. Currently, it supports setting a path component and query parameters, and
/// exposes the resulting `URLRequest` via the `request` computed property.
///
/// Example:
/// ```swift
/// let base = URL(string: "https://api.example.com")!
/// let request = RequestBuilder(base: base)
///     .setPath("v1/users")
///     .addQueryItem(name: "page", value: "2")
///     .request
/// ```
/// This produces a request targeting: https://api.example.com/v1/users?page=2
public final class RequestBuilder: URLRequestBuilder {
    /// The base URL used to compose the final request URL.
    private let base: URL
    /// Optional path component appended to the base URL.
    private var path: String?
    /// Optional query items to be appended as URL query parameters.
    private var queryItems: [URLQueryItem] = []

    /// The built `URLRequest` for the current configuration.
    ///
    /// If a `path` has been set, it is appended to `base`; otherwise the request
    /// points to `base` directly.
    public var request: URLRequest {
        var url = base
        if let path {
            url = url.appending(path: path)
        }

        if queryItems.isEmpty {
            return URLRequest(url: url)
        }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let existing = components?.queryItems ?? []
        components?.queryItems = existing + queryItems
        let finalURL = components?.url ?? url
        return URLRequest(url: finalURL)
    }

    /// Creates a new builder with the given base URL.
    /// - Parameter base: The base endpoint for the request.
    public init(base: URL) {
        self.base = base
    }

    /// Sets the path component to be appended to the base URL.
    /// - Parameter path: The path segment (do not include a leading slash when using `URL.appending(path:)`).
    /// - Returns: The same builder instance to allow method chaining.
    @discardableResult
    public func setPath(_ path: String) -> RequestBuilder {
        self.path = path
        return self
    }

    /// Sets the query items to be appended as URL query parameters.
    /// - Parameter items: The list of `URLQueryItem` to include in the request URL.
    /// - Returns: The same builder instance to allow method chaining.
    @discardableResult
    public func setQueryItems(_ items: [URLQueryItem]) -> RequestBuilder {
        self.queryItems = items
        return self
    }

    /// Adds a single query item to the request URL.
    /// - Parameters:
    ///   - name: The name of the query parameter.
    ///   - value: The value of the query parameter. If `nil`, the item is added without a value.
    /// - Returns: The same builder instance to allow method chaining.
    @discardableResult
    public func addQueryItem(name: String, value: String?) -> RequestBuilder {
        self.queryItems.append(URLQueryItem(name: name, value: value))
        return self
    }
}
