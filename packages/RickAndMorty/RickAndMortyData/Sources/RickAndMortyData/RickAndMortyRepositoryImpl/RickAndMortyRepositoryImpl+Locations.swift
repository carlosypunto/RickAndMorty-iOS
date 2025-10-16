// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import RickAndMortyDomain

public extension RickAndMortyRepositoryImpl {
    func getLocations(page: Int) async throws(RepositoryError) -> Page<Location> {
        do {
            let cacheKey: CacheKey = .locations(page: page)
            if let cached: Page<Location> = await cache.value(for: cacheKey) {
                return cached
            }
            let dto = try await services.getLocations(page: page)
            let domain = dto.toDomain
            return await caching(domain, for: cacheKey)
        } catch {
            throw RepositoryError.map(from: error)
        }
    }

    func getLocations(withIds ids: [Int]) async throws(RepositoryError) -> [Location] {
        do {
            let cacheKey: CacheKey = .locations(ids: ids)
            if let cached: [Location] = await cache.value(for: cacheKey) {
                return cached
            }
            let dto = try await services.getLocations(withIds: ids)
            let domain = dto.map(\.toDomain)
            return await caching(domain, for: cacheKey)
        } catch {
            throw RepositoryError.map(from: error)
        }
    }

    func getLocation(withId id: Int) async throws(RepositoryError) -> Location {
        do {
            let cacheKey: CacheKey =  .location(id: id)
            if let cached: Location = await cache.value(for: cacheKey) {
                return cached
            }
            let dto = try await services.getLocation(withId: id)
            let domain = dto.toDomain
            return await caching(domain, for: cacheKey)
        } catch {
            throw RepositoryError.map(from: error)
        }
    }
}
