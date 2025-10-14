// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation

extension Error {
    var isInternetOffline: Bool {
        let nsError = (self as NSError)
        return nsError.domain == "NSURLErrorDomain" && nsError.code == NSURLErrorNotConnectedToInternet
    }
}
