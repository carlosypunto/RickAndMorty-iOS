// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import NetworkClient

public enum ServiceError: Error {
    case notSucessfulResponse
    case notHTTPResponse
}

extension ServiceError {
    static func map(from error: Error) -> ServiceError {
        if let clientError = error as? NetworkClientError {
            switch clientError {
            case .notHTTPResponse:
                return .notSucessfulResponse
            case .iternetOffline:
                return .notHTTPResponse
            }
        }
        return .notSucessfulResponse
    }
}
