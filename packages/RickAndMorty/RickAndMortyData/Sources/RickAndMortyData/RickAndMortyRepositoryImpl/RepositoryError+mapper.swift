// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import RickAndMortyDomain

extension RepositoryError {
    static func map(from error: ServiceError) -> RepositoryError {
        switch error {
        case .invalidParameter(let msg): .invalidParameter(msg)
        case .offline: .offline
        case .decodeError: .decode
        case .notHTTPResponse: .server
        case .notSuccessfulResponse(let statusCode):
            switch statusCode {
            case 401,403: .unauthorized
            case 404: .notFound
            case 429: .rateLimited(retryAfter: nil)
            case 500...: .server
            default: .unknown
            }
        case .unknown: .unknown
        }
    }

    static func map(from error: Error) -> RepositoryError {
        if let serviceError = error as? ServiceError {
            return .map(from: serviceError)
        }
        return .unknown
    }
}
