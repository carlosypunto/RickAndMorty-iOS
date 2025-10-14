// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

/// This file defines errors related to network client operations.

import Foundation

/// Errors produced by `NetworkClientImpl` and related networking operations.
///
/// These cases represent high-level error conditions surfaced by the client,
/// including non-HTTP responses and offline connectivity.
enum NetworkClientError: Error, LocalizedError {
    /// The response was not an `HTTPURLResponse`.
    case notHTTPResponse
    /// The device appears to be offline. This maps from `NSURLErrorNotConnectedToInternet`.
    case iternetOffline
}
