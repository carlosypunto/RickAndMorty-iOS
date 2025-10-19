// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
@testable import RickAndMortyData

final class RickAndMortyDataSpy: RickAndMortyServices, @unchecked Sendable {
    var requestedPage: Int?
    var requestedIds: [Int]?
    var requestedId: Int?

    func getCharacters(page: Int) async throws(ServiceError) -> DTO.Page<DTO.Character> {
        requestedPage = page
        return DTO.Character.charactersPageStub
    }
    
    func getCharacters(withIds ids: [Int]) async throws(ServiceError) -> [DTO.Character] {
        requestedIds = ids
        return DTO.Character.charactersArrayStub
    }
    
    func getCharacter(withId id: Int) async throws(ServiceError) -> DTO.Character {
        requestedId = id
        return DTO.Character.firstCharacterStub
    }
    
    func getEpisodes(page: Int) async throws(ServiceError) -> DTO.Page<DTO.Episode> {
        requestedPage = page
        return DTO.Episode.episodesPageStub
    }
    
    func getEpisodes(withIds ids: [Int]) async throws(ServiceError) -> [DTO.Episode] {
        requestedIds = ids
        return DTO.Episode.episodesArrayStub
    }
    
    func getEpisode(withId id: Int) async throws(ServiceError) -> DTO.Episode {
        requestedId = id
        return DTO.Episode.firstEpisodeStub
    }
    
    func getLocations(page: Int) async throws -> DTO.Page<DTO.Location> {
        requestedPage = page
        return DTO.Location.locationsPageStub
    }
    
    func getLocations(withIds ids: [Int]) async throws(ServiceError) -> [DTO.Location] {
        requestedIds = ids
        return DTO.Location.locationsArrayStub
    }
    
    func getLocation(withId id: Int) async throws(ServiceError) -> DTO.Location {
        requestedId = id
        return DTO.Location.firstLocationStub
    }
}
