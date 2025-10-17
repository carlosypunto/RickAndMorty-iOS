// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation

enum CharacterUIStubs {
    static let rickSanchez = CharacterUI(
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
            1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
            25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46,
            47, 48, 49, 50, 51
        ],
        created: Date()
    )

    static let pageOneCharacters: [CharacterUI] = [
        rickSanchez,
        CharacterUI(
            id: 2,
            name: "Morty Smith",
            status: .alive,
            species: "Human",
            type: "",
            gender: .male,
            origin: .init(id: 0, name: "unknown"),
            location: .init(id: 3, name: "Citadel of Ricks"),
            image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
            episodes: [
                1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
                25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46,
                47, 48, 49, 50, 51
            ],
            created: Date()
        ),
        CharacterUI(
            id: 3,
            name: "Summer Smith",
            status: .alive,
            species: "Human",
            type: "",
            gender: .female,
            origin: .init(id: 20, name: "Earth (Replacement Dimension)"),
            location: .init(id: 20, name: "Earth (Replacement Dimension)"),
            image: "https://rickandmortyapi.com/api/character/avatar/3.jpeg",
            episodes: [
                6, 7, 8, 9, 10, 11, 12, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
                25, 26, 27, 29, 30, 31, 32, 33, 34, 35, 36, 38, 39, 40, 41, 42, 43,
                44, 45, 46, 47, 48, 49, 51
            ],
            created: Date()
        ),
        CharacterUI(
            id: 4,
            name: "Beth Smith",
            status: .alive,
            species: "Human",
            type: "",
            gender: .female,
            origin: .init(id: 20, name: "Earth (Replacement Dimension)"),
            location: .init(id: 20, name: "Earth (Replacement Dimension)"),
            image: "https://rickandmortyapi.com/api/character/avatar/4.jpeg",
            episodes: [
                6, 7, 8, 9, 10, 11, 12, 14, 15, 16, 18, 19, 20, 21, 22, 23, 24,
                25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 38, 39, 40, 41,
                42, 43, 44, 45, 46, 47, 48, 49, 51
            ],
            created: Date()
        ),
        CharacterUI(
            id: 5,
            name: "Jerry Smith",
            status: .alive,
            species: "Human",
            type: "",
            gender: .male,
            origin: .init(id: 20, name: "Earth (Replacement Dimension)"),
            location: .init(id: 20, name: "Earth (Replacement Dimension)"),
            image: "https://rickandmortyapi.com/api/character/avatar/5.jpeg",
            episodes: [
                6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 18, 19, 20, 21, 22, 23, 26,
                29, 30, 31, 32, 33, 35, 36, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
                48, 49, 50, 51
            ],
            created: Date()
        ),
        CharacterUI(
            id: 6,
            name: "Abadango Cluster Princess",
            status: .alive,
            species: "Alien",
            type: "",
            gender: .female,
            origin: .init(id: 2, name: "Abadango"),
            location: .init(id: 2, name: "Abadango"),
            image: "https://rickandmortyapi.com/api/character/avatar/6.jpeg",
            episodes: [27],
            created: Date()
        ),
        CharacterUI(
            id: 7,
            name: "Abradolf Lincler",
            status: .unknown,
            species: "Human",
            type: "Genetic experiment",
            gender: .male,
            origin: .init(id: 20, name: "Earth (Replacement Dimension)"),
            location: .init(id: 21, name: "Testicle Monster Dimension"),
            image: "https://rickandmortyapi.com/api/character/avatar/7.jpeg",
            episodes: [10, 11],
            created: Date()
        ),
        CharacterUI(
            id: 8,
            name: "Adjudicator Rick",
            status: .dead,
            species: "Human",
            type: "",
            gender: .male,
            origin: .init(id: 0, name: "unknown"),
            location: .init(id: 3, name: "Citadel of Ricks"),
            image: "https://rickandmortyapi.com/api/character/avatar/8.jpeg",
            episodes: [28],
            created: Date()
        ),
        CharacterUI(
            id: 9,
            name: "Agency Director",
            status: .dead,
            species: "Human",
            type: "",
            gender: .male,
            origin: .init(id: 20, name: "Earth (Replacement Dimension)"),
            location: .init(id: 20, name: "Earth (Replacement Dimension)"),
            image: "https://rickandmortyapi.com/api/character/avatar/9.jpeg",
            episodes: [24],
            created: Date()
        ),
        CharacterUI(
            id: 10,
            name: "Alan Rails",
            status: .dead,
            species: "Human",
            type: "Superhuman (Ghost trains summoner)",
            gender: .male,
            origin: .init(id: 0, name: "unknown"),
            location: .init(id: 4, name: "Worldender\'s lair"),
            image: "https://rickandmortyapi.com/api/character/avatar/10.jpeg",
            episodes: [25],
            created: Date()
        ),
        CharacterUI(
            id: 11,
            name: "Albert Einstein",
            status: .dead,
            species: "Human",
            type: "",
            gender: .male,
            origin: .init(id: 1, name: "Earth (C-137)"),
            location: .init(id: 20, name: "Earth (Replacement Dimension)"),
            image: "https://rickandmortyapi.com/api/character/avatar/11.jpeg",
            episodes: [12],
            created: Date()
        ),
        CharacterUI(
            id: 12,
            name: "Alexander",
            status: .dead,
            species: "Human",
            type: "",
            gender: .male,
            origin: .init(id: 1, name: "Earth (C-137)"),
            location: .init(id: 5, name: "Anatomy Park"),
            image: "https://rickandmortyapi.com/api/character/avatar/12.jpeg",
            episodes: [3],
            created: Date()
        ),
        CharacterUI(
            id: 13,
            name: "Alien Googah",
            status: .unknown,
            species: "Alien",
            type: "",
            gender: .unknown,
            origin: .init(id: 0, name: "unknown"),
            location: .init(id: 20, name: "Earth (Replacement Dimension)"),
            image: "https://rickandmortyapi.com/api/character/avatar/13.jpeg",
            episodes: [31],
            created: Date()
        ),
        CharacterUI(
            id: 14,
            name: "Alien Morty",
            status: .unknown,
            species: "Alien",
            type: "",
            gender: .male,
            origin: .init(id: 0, name: "unknown"),
            location: .init(id: 3, name: "Citadel of Ricks"),
            image: "https://rickandmortyapi.com/api/character/avatar/14.jpeg",
            episodes: [10],
            created: Date()
        ),
        CharacterUI(
            id: 15,
            name: "Alien Rick",
            status: .unknown,
            species: "Alien",
            type: "",
            gender: .male,
            origin: .init(id: 0, name: "unknown"),
            location: .init(id: 3, name: "Citadel of Ricks"),
            image: "https://rickandmortyapi.com/api/character/avatar/15.jpeg",
            episodes: [10],
            created: Date()
        ),
        CharacterUI(
            id: 16,
            name: "Amish Cyborg",
            status: .dead,
            species: "Alien",
            type: "Parasite",
            gender: .male,
            origin: .init(id: 0, name: "unknown"),
            location: .init(id: 20, name: "Earth (Replacement Dimension)"),
            image: "https://rickandmortyapi.com/api/character/avatar/16.jpeg",
            episodes: [15],
            created: Date()
        ),
        CharacterUI(
            id: 17,
            name: "Annie",
            status: .alive,
            species: "Human",
            type: "",
            gender: .female,
            origin: .init(id: 1, name: "Earth (C-137)"),
            location: .init(id: 5, name: "Anatomy Park"),
            image: "https://rickandmortyapi.com/api/character/avatar/17.jpeg",
            episodes: [3],
            created: Date()
        ),
        CharacterUI(
            id: 18,
            name: "Antenna Morty",
            status: .alive,
            species: "Human",
            type: "Human with antennae",
            gender: .male,
            origin: .init(id: 0, name: "unknown"),
            location: .init(id: 3, name: "Citadel of Ricks"),
            image: "https://rickandmortyapi.com/api/character/avatar/18.jpeg",
            episodes: [
                10,
                28
            ],
            created: Date()
        ),
        CharacterUI(
            id: 19,
            name: "Antenna Rick",
            status: .unknown,
            species: "Human",
            type: "Human with antennae",
            gender: .male,
            origin: .init(id: 0, name: "unknown"),
            location: .init(id: 0, name: "unknown"),
            image: "https://rickandmortyapi.com/api/character/avatar/19.jpeg",
            episodes: [10],
            created: Date()
        ),
        CharacterUI(
            id: 20,
            name: "Ants in my Eyes Johnson",
            status: .unknown,
            species: "Human",
            type: "Human with ants in his eyes",
            gender: .male,
            origin: .init(id: 0, name: "unknown"),
            location: .init(id: 6, name: "Interdimensional Cable"),
            image: "https://rickandmortyapi.com/api/character/avatar/20.jpeg",
            episodes: [8],
            created: Date()
        )
    ]
}
