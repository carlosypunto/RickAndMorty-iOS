// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation

protocol RickAndMortyServices: Sendable {
    func getCharacters(page: Int) async throws(ServiceError) -> DTO.Page<DTO.Character>
    func getCharacters(withIds ids: [Int]) async throws(ServiceError) -> [DTO.Character]
    func getCharacter(withId id: Int) async throws(ServiceError) -> DTO.Character

    func getEpisodes(page: Int) async throws(ServiceError) -> DTO.Page<DTO.Episode>
    func getEpisodes(withIds ids: [Int]) async throws(ServiceError) -> [DTO.Episode]
    func getEpisode(withId id: Int) async throws(ServiceError) -> DTO.Episode

    func getLocations(page: Int) async throws -> DTO.Page<DTO.Location>
    func getLocations(withIds ids: [Int]) async throws(ServiceError) -> [DTO.Location]
    func getLocation(withId id: Int) async throws(ServiceError) -> DTO.Location
}
