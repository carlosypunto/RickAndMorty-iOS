// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation

extension Array<String> {
    var idsFromURLs: [Int] {
        let ids = self.compactMap { URL(string: $0) }
            .map(\.lastPathComponent)
            .compactMap(Int.init)
        return ids
    }
}
