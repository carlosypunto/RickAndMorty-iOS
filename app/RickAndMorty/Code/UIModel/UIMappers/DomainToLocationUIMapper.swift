// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import RickAndMortyDomain

public extension Location {
    var toUI: LocationUI {
        LocationUI(
            id: id,
            name: name,
            type: type,
            dimension: dimension,
            residents: residents,
            created: created
        )
    }
}
