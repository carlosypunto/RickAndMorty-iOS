// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import RickAndMortyDomain

public extension RickAndMortyRepositoryImpl {
    func getCharacters(page: Int) async throws(RepositoryError) -> Page<Character> {
        do {
            let cacheKey: CacheKey = .characters(page: page)
            if let cached: Page<Character> = await cache.value(for: cacheKey) {
                return cached
            }
            let dto = try await services.getCharacters(page: page)
            let domain = dto.toDomain
            return await caching(domain, for: cacheKey)
        } catch {
            throw RepositoryError.map(from: error)
        }
    }

    func getCharacters(withIds ids: [Int]) async throws(RepositoryError) -> [Character] {
        do {
            let cacheKey: CacheKey = .characters(ids: ids)
            if let cached: [Character] = await cache.value(for: cacheKey) {
                return cached
            }
            let dto = try await services.getCharacters(withIds: ids)
            let domain = dto.map(\.toDomain)
            return await caching(domain, for: cacheKey)
        } catch {
            throw RepositoryError.map(from: error)
        }
    }

    func getCharacter(withId id: Int) async throws(RepositoryError) -> Character {
        do {
            let cacheKey: CacheKey =  .character(id: id)
            if let cached: Character = await cache.value(for: cacheKey) {
                return cached
            }
            let dto = try await services.getCharacter(withId: id)
            let domain = dto.toDomain
            return await caching(domain, for: cacheKey)
        } catch {
            throw RepositoryError.map(from: error)
        }
    }
}
