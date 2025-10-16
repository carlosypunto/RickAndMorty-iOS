// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import NetworkClient

enum ServiceError: Error, Equatable {
    case invalidParameter(String)
    case decodeError
    case notSuccessfulResponse(statusCode: Int)
    case offline
    case notHTTPResponse
    case unknown
}

extension ServiceError {
    static func map(from error: Error) -> ServiceError {
        if let serviceError = error as? ServiceError {
            return serviceError
        }

        if let clientError = error as? NetworkClientError {
            switch clientError {
            case .notHTTPResponse:
                return .notHTTPResponse
            case .internetOffline:
                return .offline
            }
        }

        return .unknown
    }
}
