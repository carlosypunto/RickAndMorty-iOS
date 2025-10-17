// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import RickAndMortyDomain

public extension Episode {
    var toUI: EpisodeUI {
        EpisodeUI(
            id: id,
            title: title,
            characters: characters,
            airDate: airDate,
            created: created
        )
    }
}
