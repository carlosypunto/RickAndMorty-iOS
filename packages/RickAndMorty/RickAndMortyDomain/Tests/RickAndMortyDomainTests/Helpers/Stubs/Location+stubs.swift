// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
@testable import RickAndMortyDomain

extension Location {
    static var locationsPageStub: Page<Location> {
        Page<Location>(
            isLast: false,
            elements: locationsArrayStub
        )
    }

    static let locationsArrayStub: [Location] = [firstLocationStub, secondLocationStub]

    static let firstLocationStub =  Location(
        id: 1,
        name: "Earth (C-137)",
        type: "Planet",
        dimension: "Dimension C-137",
        residents: [38, 45, 71, 82, 83, 92, 112, 114, 116, 117, 120, 127, 155, 169, 175, 179, 186, 201, 216, 239, 271, 302, 303, 338, 343, 356, 394],
        created: Date()
    )

    static let secondLocationStub = Location(
        id: 2,
        name: "Abadango",
        type: "Cluster",
        dimension: "unknown",
        residents: [6],
        created: Date()
    )
}
