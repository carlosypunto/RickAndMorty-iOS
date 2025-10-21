// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import RickAndMortyDomain

final class GetEpisodesByIdsUseCaseStub: GetEpisodesByIdsUseCase, @unchecked Sendable {
    func execute(ids: [Int]) async throws(RepositoryError) -> [Episode] {
        return [
            Episode(
                id: 2,
                title: "Lawnmower Dog",
                episode: "S01E02",
                characters: [1, 2, 38, 46, 63, 80, 175, 221, 239, 246, 304, 305, 306, 329, 338, 396, 397, 398, 405],
                airDate: "December 9, 2013",
                created: Date()
            ),
            Episode(
                id: 3,
                title: "Anatomy Park",
                episode: "S01E03",
                characters: [1, 2, 38, 46, 63, 80, 175, 221, 239, 246, 304, 305, 306, 329, 338, 396, 397, 398, 405],
                airDate: "December 16, 2013",
                created: Date()
            )
        ]
    }
}
