// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

/// A lightweight, actor-isolated cache abstraction used by repositories.
///
/// `RepositoryCache` provides type-erased storage keyed by `CacheKey` while
/// guaranteeing thread-safety via Swift Concurrency. Because it is an `Actor`,
/// all operations are serialized, preventing data races when accessed from
/// concurrent tasks.
///
/// Typical usage inside a repository:
///
/// ```swift
/// let key: CacheKey = .characters(page: 1)
/// if let cached: Page<Character> = await cache.value(for: key) {
///     return cached
/// }
/// let fresh = try await services.getCharacters(page: 1).toDomain
/// await cache.insert(fresh, for: key)
/// return fresh
/// ```
///
/// Implementations may choose any backing store (e.g., in-memory, disk, or
/// hybrid). Values are generic; callers are responsible for requesting the
/// expected type when reading.
public protocol RepositoryCache: Actor {
    /// Returns the cached value for a given key, cast to the requested type.
    ///
    /// - Parameter key: The `CacheKey` under which the value may be stored.
    /// - Returns: The value as `T` if present and type matches; otherwise `nil`.
    /// - Note: Callers must request the same concrete type they stored.
    func value<T>(for key: CacheKey) -> T?
    
    /// Inserts or replaces a value for the given key.
    ///
    /// - Parameters:
    ///   - value: The value to store. Consider using `Sendable` types when sharing across tasks.
    ///   - key: The `CacheKey` that identifies the entry.
    func insert<T>(_ value: T, for key: CacheKey)
    
    /// Removes any cached value associated with the given key.
    ///
    /// - Parameter key: The key whose value should be removed.
    func removeValue(for key: CacheKey)
    
    /// Removes all cached entries from the cache.
    func removeAll()
}

/// Strongly-typed keys for repository cache entries.
///
/// Each case represents a distinct namespace and identity for cached data
/// fetched by the repository (e.g., paginated lists, batched IDs, or single
/// resources). Conformance to `Hashable` enables use in dictionaries/sets, and
/// `Sendable` allows safe use across concurrency domains.
///
/// When adding new repository endpoints, prefer introducing a new case here to
/// keep cache keys centralized and discoverable.
public enum CacheKey: Hashable, Sendable {
    /// Characters list for a specific page number.
    case characters(page: Int)
    /// Batch of characters identified by a set of IDs.
    case characters(ids: [Int])
    /// Single character identified by its unique ID.
    case character(id: Int)

    /// Episodes list for a specific page number.
    case episodes(page: Int)
    /// Batch of episodes identified by a set of IDs.
    case episodes(ids: [Int])
    /// Single episode identified by its unique ID.
    case episode(id: Int)

    /// Locations list for a specific page number.
    case locations(page: Int)
    /// Batch of locations identified by a set of IDs.
    case locations(ids: [Int])
    /// Single location identified by its unique ID.
    case location(id: Int)
}
