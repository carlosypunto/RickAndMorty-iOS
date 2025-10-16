// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import RickAndMortyDomain

public extension RickAndMortyRepositoryImpl {
    func getEpisodes(page: Int) async throws(RepositoryError) -> Page<Episode> {
        do {
            let page = try await services.getEpisodes(page: page)
            return page.toDomain
        } catch {
            throw RepositoryError.map(from: error)
        }
    }

    func getEpisodes(withIds ids: [Int]) async throws(RepositoryError) -> [Episode] {
        do {
            let episodes = try await services.getEpisodes(withIds: ids)
            return episodes.map(\.toDomain)
        } catch {
            throw RepositoryError.map(from: error)
        }
    }

    func getEpisode(withId id: Int) async throws(RepositoryError) -> Episode {
        do {
            let episode = try await services.getEpisode(withId: id)
            return episode.toDomain
        } catch {
            throw RepositoryError.map(from: error)
        }
    }
}
