// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation

/// Repository-layer domain error, intended for UI/use-case handling.
public enum RepositoryError: Error, Equatable {
    /// Indicates invalid input provided by callers (e.g., filters, pagination).
    /// The associated string describes the offending parameter.
    case invalidParameter(String)
    /// Resource was not found. Typically mapped from 404 responses in ServiceError.
    case notFound
    /// Request was rate limited (HTTP 429). Contains an optional retry-after in seconds if provided by the backend.
    case rateLimited(retryAfter: TimeInterval?)
    /// Server-side failure (5xx) or unexpected backend error.
    case server
    /// Authentication/authorization failed (e.g., 401/403).
    case unauthorized
    /// No internet connectivity or network is unreachable.
    case offline
    /// Failed to decode the service payload into domain models. Often indicates contract drift or a bug.
    case decode
    /// Fallback for unclassified or unexpected errors. Consider logging the underlying cause.
    case unknown
}
