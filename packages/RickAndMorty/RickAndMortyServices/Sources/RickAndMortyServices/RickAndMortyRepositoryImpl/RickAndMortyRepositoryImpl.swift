// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import RickAndMortyDomain

/// Concrete implementation of `RickAndMortyRepository`.
///
/// This repository coordinates access to the Rick and Morty data sources
/// through an internal `RickAndMortyServices` abstraction. The default
/// initializer wires the production `RickAndMortyServicesImpl` to keep
/// construction simple for consumers while preserving testability via the
/// internal, dependency-injected initializer.
public final class RickAndMortyRepositoryImpl: RickAndMortyRepository {
    let services: RickAndMortyServices

    /// Creates a repository configured with the default production services.
    ///
    /// Use this initializer in app code to obtain a ready-to-use repository.
    /// For testing, prefer the internal initializer that accepts a custom
    /// `RickAndMortyServices` implementation.
    public init() {
        self.services = RickAndMortyServicesImpl()
    }

    // Not public for restrict access to RickAndMortyServices an it's implementation
    init(services: RickAndMortyServices = RickAndMortyServicesImpl()) {
        self.services = services
    }
}
