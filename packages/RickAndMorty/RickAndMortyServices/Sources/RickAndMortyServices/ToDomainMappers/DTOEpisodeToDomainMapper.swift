// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import RickAndMortyDomain

extension DTO.Page<DTO.Episode> {
    var toDomain: RickAndMortyDomain.Page<RickAndMortyDomain.Episode> {
        RickAndMortyDomain.Page(
            isLast: info.next == nil,
            elements: results.map(\.toDomain)
        )
    }
}

extension DTO.Episode {
    var toDomain: RickAndMortyDomain.Episode {
        RickAndMortyDomain.Episode(
            id: id,
            title: name,
            characters: characters.idsFromURLs,
            airDate: airDate,
            created: created
        )
    }
}
