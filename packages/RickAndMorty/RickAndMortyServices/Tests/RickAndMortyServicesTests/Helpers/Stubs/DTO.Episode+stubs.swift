// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
@testable import RickAndMortyServices

extension DTO.Episode {
    static var episodesPageStub: DTO.Page<DTO.Episode> {
        DTO.Page<DTO.Episode>(
            info: DTO.Info(
                count: 51,
                pages: 3,
                next: "https://rickandmortyapi.com/api/episode/?page=2",
                prev: nil
            ),
            results: episodesArrayStub
        )
    }

    static let episodesArrayStub: [DTO.Episode] = [firstEpisodeStub, secondEpisodeStub]

    static let firstEpisodeStub = DTO.Episode(
        id: 2,
        name: "Lawnmower Dog",
        airDate: "December 9, 2013",
        episode: "S01E02",
        characters: [
            "https://rickandmortyapi.com/api/character/1",
            "https://rickandmortyapi.com/api/character/2",
            "https://rickandmortyapi.com/api/character/38",
            "https://rickandmortyapi.com/api/character/46",
            "https://rickandmortyapi.com/api/character/63",
            "https://rickandmortyapi.com/api/character/80",
            "https://rickandmortyapi.com/api/character/175",
            "https://rickandmortyapi.com/api/character/221",
            "https://rickandmortyapi.com/api/character/239",
            "https://rickandmortyapi.com/api/character/246",
            "https://rickandmortyapi.com/api/character/304",
            "https://rickandmortyapi.com/api/character/305",
            "https://rickandmortyapi.com/api/character/306",
            "https://rickandmortyapi.com/api/character/329",
            "https://rickandmortyapi.com/api/character/338",
            "https://rickandmortyapi.com/api/character/396",
            "https://rickandmortyapi.com/api/character/397",
            "https://rickandmortyapi.com/api/character/398",
            "https://rickandmortyapi.com/api/character/405",
        ],
        url: "https://rickandmortyapi.com/api/episode/2",
        created: Formatter.customISO8601DateFormatter.date(from: "2017-11-10T12:56:33.916Z")!
    )

    static let secondEpisodeStub = DTO.Episode(
        id: 3,
        name: "Anatomy Park",
        airDate: "December 16, 2013",
        episode: "S01E03",
        characters: [
            "https://rickandmortyapi.com/api/character/1",
            "https://rickandmortyapi.com/api/character/2",
            "https://rickandmortyapi.com/api/character/38",
            "https://rickandmortyapi.com/api/character/46",
            "https://rickandmortyapi.com/api/character/63",
            "https://rickandmortyapi.com/api/character/80",
            "https://rickandmortyapi.com/api/character/175",
            "https://rickandmortyapi.com/api/character/221",
            "https://rickandmortyapi.com/api/character/239",
            "https://rickandmortyapi.com/api/character/246",
            "https://rickandmortyapi.com/api/character/304",
            "https://rickandmortyapi.com/api/character/305",
            "https://rickandmortyapi.com/api/character/306",
            "https://rickandmortyapi.com/api/character/329",
            "https://rickandmortyapi.com/api/character/338",
            "https://rickandmortyapi.com/api/character/396",
            "https://rickandmortyapi.com/api/character/397",
            "https://rickandmortyapi.com/api/character/398",
            "https://rickandmortyapi.com/api/character/405",
        ],
        url: "https://rickandmortyapi.com/api/episode/3",
        created: Formatter.customISO8601DateFormatter.date(from: "2017-11-10T12:56:33.916Z")!
    )
}

