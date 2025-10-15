// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation

public struct Episode {
    let id: Int
    let title: String
    let characters: [Int]
    let airDate: Date
    let created: Date

    public init(
        id: Int,
        title: String,
        characters: [Int],
        airDate: Date,
        created: Date
    ) {
        self.id = id
        self.title = title
        self.characters = characters
        self.airDate = airDate
        self.created = created
    }
}
