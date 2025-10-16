// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation

extension JSONDecoder.DateDecodingStrategy {
    static let customWithISO8601Formatter: JSONDecoder.DateDecodingStrategy = {
        return .custom { decoder in
            let str = try decoder.singleValueContainer().decode(String.self)
            guard let date = Formatter.customISO8601DateFormatter.date(from: str) else {
                throw ServiceError.decodeError
            }
            return date
        }
    }()
}
