// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import RickAndMortyDomain

extension DTO.Page<DTO.Episode> {
    var toDomain: Page<Episode> {
        Page(
            isLast: info.next == nil,
            elements: results.map(\.toDomain)
        )
    }
}

extension DTO.Episode {
    var toDomain: Episode {
        Episode(
            id: id,
            title: name,
            episode: episode,
            characters: characters.idsFromURLs,
            airDate: airDate,
            created: created
        )
    }
}
