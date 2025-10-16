// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import RickAndMortyDomain

public extension RickAndMortyRepositoryImpl {
    func getCharacters(page: Int) async throws(RepositoryError) -> Page<Character> {
        do {
            let page = try await services.getCharacters(page: page)
            return page.toDomain
        } catch {
            throw RepositoryError.map(from: error)
        }
    }

    func getCharacters(withIds ids: [Int]) async throws(RepositoryError) -> [Character] {
        do {
            let characters = try await services.getCharacters(withIds: ids)
            return characters.map(\.toDomain)
        } catch {
            throw RepositoryError.map(from: error)
        }
    }

    func getCharacter(withId id: Int) async throws(RepositoryError) -> Character {
        do {
            let character = try await services.getCharacter(withId: id)
            return character.toDomain
        } catch {
            throw RepositoryError.map(from: error)
        }
    }
}
