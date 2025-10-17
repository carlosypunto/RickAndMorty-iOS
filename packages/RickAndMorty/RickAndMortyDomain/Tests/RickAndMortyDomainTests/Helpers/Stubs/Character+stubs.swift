// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
@testable import RickAndMortyDomain

extension Character {
    static var charactersPageStub: Page<Character> {
        Page<Character>(
            isLast: false,
            elements: charactersArrayStub
        )
    }

    static let charactersArrayStub: [Character] = [firstCharacterStub, secondCharacterStub]

    static let firstCharacterStub = Character(
        id: 1,
        name: "Rick Sanchez",
        status: .alive,
        species: "Human",
        type: "",
        gender: .male,
        origin: .init(id: 1, name: "Earth (C-137)"),
        location: .init(id: 3, name: "Citadel of Ricks"),
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        episodes: [
            1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22,
            23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42,
            43, 44, 45, 46, 47, 48, 49, 50, 51],
        created: Date()
    )

    static let secondCharacterStub = Character(
        id: 2,
        name: "Morty Smith",
        status: .alive,
        species: "Human",
        type: "",
        gender: .male,
        origin: .init(id: -1, name: "unknown"),
        location: .init(id: 3, name: "Citadel of Ricks"),
        image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
        episodes: [
            1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22,
            23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42,
            43, 44, 45, 46, 47, 48, 49, 50, 51],
        created: Date()
    )
}
