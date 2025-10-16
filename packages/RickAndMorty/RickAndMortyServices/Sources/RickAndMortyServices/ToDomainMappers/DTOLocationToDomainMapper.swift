// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import RickAndMortyDomain

extension DTO.Page<DTO.Location> {
    var toDomain: RickAndMortyDomain.Page<RickAndMortyDomain.Location> {
        RickAndMortyDomain.Page(
            isLast: info.next == nil,
            elements: results.map(\.toDomain)
        )
    }
}

extension DTO.Location {
    var toDomain: RickAndMortyDomain.Location {
        RickAndMortyDomain.Location(
            id: id,
            name: name,
            type: type,
            dimension: dimension,
            residents: residents.idsFromURLs,
            created: created
        )
    }
}
