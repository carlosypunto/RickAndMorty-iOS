// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import RickAndMortyDomain

public extension RickAndMortyRepositoryImpl {
    func getLocations(page: Int) async throws(RepositoryError) -> Page<Location> {
        do {
            let page = try await services.getLocations(page: page)
            return page.toDomain
        } catch {
            throw RepositoryError.map(from: error)
        }
    }

    func getLocations(withIds ids: [Int]) async throws(RepositoryError) -> [Location] {
        do {
            let locations = try await services.getLocations(withIds: ids)
            return locations.map(\.toDomain)
        } catch {
            throw RepositoryError.map(from: error)
        }
    }

    func getLocation(withId id: Int) async throws(RepositoryError) -> Location {
        do {
            let location = try await services.getLocation(withId: id)
            return location.toDomain
        } catch {
            throw RepositoryError.map(from: error)
        }
    }
}
