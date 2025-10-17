// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
@testable import RickAndMortyDomain

final class RickAndMortyRepositorySpy: RickAndMortyRepository {
    var requestedPage: Int?
    var requestedIds: [Int]?
    var requestedId: Int?

    func getCharacters(page: Int) async throws(RepositoryError) -> Page<Character> {
        requestedPage = page
        return Character.charactersPageStub
    }
    
    func getCharacters(withIds ids: [Int]) async throws(RepositoryError) -> [Character] {
        requestedIds = ids
        return Character.charactersArrayStub
    }
    
    func getCharacter(withId id: Int) async throws(RepositoryError) -> Character {
        requestedId = id
        return Character.firstCharacterStub
    }
    
    func getEpisodes(page: Int) async throws(RepositoryError) -> Page<Episode> {
        requestedPage = page
        return Episode.episodesPageStub
    }
    
    func getEpisodes(withIds ids: [Int]) async throws(RepositoryError) -> [Episode] {
        requestedIds = ids
        return Episode.episodesArrayStub
    }
    
    func getEpisode(withId id: Int) async throws(RepositoryError) -> Episode {
        requestedId = id
        return Episode.firstEpisodeStub
    }

    func getLocations(page: Int) async throws(RepositoryError) -> Page<Location> {
        requestedPage = page
        return Location.locationsPageStub
    }
    
    func getLocations(withIds ids: [Int]) async throws(RepositoryError) -> [Location] {
        requestedIds = ids
        return Location.locationsArrayStub
    }
    
    func getLocation(withId id: Int) async throws(RepositoryError) -> Location {
        requestedId = id
        return Location.firstLocationStub
    }
}
