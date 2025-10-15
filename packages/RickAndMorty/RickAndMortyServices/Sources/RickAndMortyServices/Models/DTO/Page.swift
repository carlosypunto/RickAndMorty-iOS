// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

extension DTO {
    struct Page<Element: Codable>: Codable {
        let info: Info
        let results: [Element]
    }

    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
}
