// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

@testable import RickAndMortyServices

extension DTO.Location {
    static var locationsPageStub: DTO.Page<DTO.Location> {
        DTO.Page<DTO.Location>(
            info: DTO.Info(
                count: 51,
                pages: 3,
                next: "https://rickandmortyapi.com/api/episode/?page=2",
                prev: nil
            ),
            results: locationsArrayStub
        )
    }

    static let locationsArrayStub: [DTO.Location] = [firstLocationStub, secondLocationStub]

    static let firstLocationStub = DTO.Location(
        name: "Earth (C-137)",
        url: "https://rickandmortyapi.com/api/location/1"
    )

    static let secondLocationStub = DTO.Location(
        name: "Abadango",
        url: "https://rickandmortyapi.com/api/location/2"
    )
}
