// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation

public struct EpisodeUI: Sendable, Identifiable, Equatable {
    public let id: Int
    public let title: String
    public let characters: [Int]
    public let airDate: String
    public let created: Date

    public init(
        id: Int,
        title: String,
        characters: [Int],
        airDate: String,
        created: Date
    ) {
        self.id = id
        self.title = title
        self.characters = characters
        self.airDate = airDate
        self.created = created
    }
}
