// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

/// A simple in-memory implementation of `RepositoryCache`.
///
/// `MemoryCache` stores values in a process-local dictionary keyed by `CacheKey`.
/// It is actor-isolated for thread-safety and does not implement expiration or
/// eviction policies. Suitable as a fast, best-effort cache for repositories in
/// production, and as a deterministic fake in tests.
public actor MemoryCache: RepositoryCache {
    private var dict: [CacheKey: Any] = [:]

    /// Creates an empty in-memory cache.
    public init() {}

    /// Returns a value for `key` if present, cast to the requested type.
    /// - Note: Returns `nil` if the stored value is absent or of a different type.
    public func value<T>(for key: CacheKey) -> T? { dict[key] as? T }

    /// Stores `value` under `key`, replacing any existing entry.
    public func insert<T>(_ value: T, for key: CacheKey) { dict[key] = value }

    /// Removes the cached entry associated with `key`.
    public func removeValue(for key: CacheKey) { dict[key] = nil }

    /// Clears all entries from the in-memory store.
    public func removeAll() { dict.removeAll() }
}
