// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation

/// Protocol that defines a builder for configuring and producing a `URLRequest`.
///
/// Implementations typically expose fluent methods to customize request components
/// (such as path, query, headers, and body) and provide access to the final `URLRequest`.
///
/// ## Discussion
/// In future iterations, this builder is also intended to retain a mutable reference to the
/// underlying `URLRequest` so that clients can apply late-bound mutations (e.g., injecting
/// refreshed authorization headers or correlation IDs) and perform controlled retries.
/// This enables robust retry strategies (such as token refresh + idempotent re-dispatch)
/// while preserving request semantics. Implementations should carefully manage thread-safety
/// and visibility guarantees when mutating shared state, and ensure that request bodies are
/// either idempotent or re-creatable for safe replay.
public protocol URLRequestBuilder {
    /// The fully configured `URLRequest` produced by the builder.
    var request: URLRequest { get }
    /// Sets or replaces the path component of the request URL.
    /// - Parameter path: The path to apply (e.g., "/v1/users").
    /// - Returns: The builder instance to allow fluent chaining.
    func setPath(_ path: String) -> RequestBuilder
}
