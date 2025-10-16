// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import RickAndMortyDomain

/// Concrete implementation of `RickAndMortyRepository`.
///
/// This repository coordinates access to Rick and Morty data sources
/// through an internal `RickAndMortyServices` abstraction, and applies
/// lightweight result caching via a `RepositoryCache` (in-memory by default).
///
/// - Caching: Results obtained from services can be stored in the provided
///   cache to avoid redundant work and improve performance. The default
///   cache is `MemoryCache`, but any `RepositoryCache` implementation can
///   be injected for custom behaviors (e.g., persistence, size limits, or
///   eviction policies).
public final class RickAndMortyRepositoryImpl: RickAndMortyRepository {
    /// Backing services used to fetch and transform Rick and Morty data.
    let services: RickAndMortyServices
    /// Cache used to store and retrieve repository results keyed by `CacheKey`.
    let cache: RepositoryCache

    /// Stores a value in the repository cache under the given key and returns it.
    ///
    /// This helper enables fluent caching of results produced by service calls.
    /// - Parameters:
    ///   - value: The value to cache.
    ///   - key: The cache key under which the value will be stored.
    /// - Returns: The same value passed in, after insertion, to aid chaining.
    @discardableResult
    func caching<T: Sendable>(_ value: T, for key: CacheKey) async -> T {
        await cache.insert(value, for: key)
        return value
    }

    /// Creates a repository configured with the default production services and a cache.
    ///
    /// Use this initializer in app code to obtain a ready-to-use repository.
    /// It wires `RickAndMortyServicesImpl` as the production services and uses
    /// the supplied `RepositoryCache` for memoizing results (defaults to `MemoryCache`).
    ///
    /// - Parameter cache: The cache instance used by the repository to store
    ///   and retrieve values. Defaults to an in-memory cache (`MemoryCache`).
    public init(cache: RepositoryCache = MemoryCache()) {
        self.services = RickAndMortyServicesImpl()
        self.cache = cache
    }

    /// Internal initializer for testing and advanced configuration.
    ///
    /// Allows injecting a custom `RickAndMortyServices` implementation and a
    /// `RepositoryCache`. Use this from tests to substitute fakes/mocks or to
    /// experiment with different cache strategies. It is not public for restrict access to
    /// RickAndMortyServices an it's implementation
    ///
    /// - Parameters:
    ///   - services: The services abstraction used to access remote/local data.
    ///     Defaults to `RickAndMortyServicesImpl()`.
    ///   - cache: The cache used to store results. Defaults to `MemoryCache()`.
    init(services: RickAndMortyServices = RickAndMortyServicesImpl(), cache: RepositoryCache = MemoryCache()) {
        self.services = services
        self.cache = cache
    }
}

