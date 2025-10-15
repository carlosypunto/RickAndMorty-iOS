// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let iso8601Formatter: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        return dateFormatter
    }()
}
