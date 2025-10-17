// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import RickAndMortyDomain

extension ScreenError {
    static func from(_ error: RepositoryError) -> ScreenError {
        switch error {
            case .rateLimited:
                .canRetry
            case .offline:
                .offline
            case .invalidParameter, .notFound, .server, .unauthorized, .decode, .unknown:
                .unmanageable
        }
    }
}
