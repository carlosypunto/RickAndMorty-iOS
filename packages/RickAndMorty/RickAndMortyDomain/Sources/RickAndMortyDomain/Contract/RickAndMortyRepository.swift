// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation

public protocol RickAndMortyRepository {
    func getCharacters(page: Int) async throws -> Page<Character>
    func getLocations(page: Int) async throws -> Page<Location>
    func getEpisodes(page: Int) async throws -> Page<Episode>

    func getCharacters(withIds ids: [Int]) async throws -> [Character]
    func getLocations(withIds ids: [Int]) async throws -> [Location]
    func getEpisodes(withIds ids: [Int]) async throws -> [Episode]

    func getCharacter(withId id: Int) async throws -> Character
    func getLocation(withId id: Int) async throws -> Location
    func getEpisode(withId id: Int) async throws -> Episode
}
