// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation

extension Formatter {
    nonisolated(unsafe) static let customISO8601DateFormatter: ISO8601DateFormatter = {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return dateFormatter
    }()
}
