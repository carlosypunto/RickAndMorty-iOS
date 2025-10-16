// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import RickAndMortyDomain

public extension RickAndMortyRepositoryImpl {
    func getEpisodes(page: Int) async throws(RepositoryError) -> Page<Episode> {
        do {
            let cacheKey: CacheKey = .episodes(page: page)
            if let cached: Page<Episode> = await cache.value(for: cacheKey) {
                return cached
            }
            let dto = try await services.getEpisodes(page: page)
            let domain = dto.toDomain
            return await caching(domain, for: cacheKey)
        } catch {
            throw RepositoryError.map(from: error)
        }
    }

    func getEpisodes(withIds ids: [Int]) async throws(RepositoryError) -> [Episode] {
        do {
            let cacheKey: CacheKey = .episodes(ids: ids)
            if let cached: [Episode] = await cache.value(for: cacheKey) {
                return cached
            }
            let dto = try await services.getEpisodes(withIds: ids)
            let domain = dto.map(\.toDomain)
            return await caching(domain, for: cacheKey)
        } catch {
            throw RepositoryError.map(from: error)
        }
    }

    func getEpisode(withId id: Int) async throws(RepositoryError) -> Episode {
        do {
            let cacheKey: CacheKey =  .episode(id: id)
            if let cached: Episode = await cache.value(for: cacheKey) {
                return cached
            }
            let dto = try await services.getEpisode(withId: id)
            let domain = dto.toDomain
            return await caching(domain, for: cacheKey)
        } catch {
            throw RepositoryError.map(from: error)
        }
    }
}
