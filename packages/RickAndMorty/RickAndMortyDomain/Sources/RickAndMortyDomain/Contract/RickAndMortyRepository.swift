// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation

public protocol RickAndMortyRepository {
    func getCharacters(page: Int) async throws(RepositoryError) -> Page<Character>
    func getCharacters(withIds ids: [Int]) async throws(RepositoryError) -> [Character]
    func getCharacter(withId id: Int) async throws(RepositoryError) -> Character

    func getEpisodes(page: Int) async throws(RepositoryError) -> Page<Episode>
    func getEpisodes(withIds ids: [Int]) async throws(RepositoryError) -> [Episode]
    func getEpisode(withId id: Int) async throws(RepositoryError) -> Episode

    func getLocations(page: Int) async throws(RepositoryError) -> Page<Location>
    func getLocations(withIds ids: [Int]) async throws(RepositoryError) -> [Location]
    func getLocation(withId id: Int) async throws(RepositoryError) -> Location
}
