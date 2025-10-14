// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation

public protocol RickAndMortyServices {
    func getCharacters(page: Int) async throws -> Data
    func getLocations(page: Int) async throws -> Data
    func getEpisodes(page: Int) async throws -> Data
    func getCharacter(withId id: Int) async throws -> Data
    func getLocation(withId id: Int) async throws -> Data
    func getEpisode(withId id: Int) async throws -> Data
}
