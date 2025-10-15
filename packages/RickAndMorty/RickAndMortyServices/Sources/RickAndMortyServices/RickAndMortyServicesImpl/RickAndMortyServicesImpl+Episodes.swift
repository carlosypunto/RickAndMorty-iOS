// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import NetworkClient

extension RickAndMortyServicesImpl {
    func getEpisodes(page: Int) async throws(ServiceError) -> DTO.Page<DTO.Episode> {
        assert(page > 0, "page must be greater than zero")
        let builder = RequestBuilder(base: baseURL)
        builder.setPath("episode")
        if page > 1 {
            builder.addQueryItem(name: "page", value: "\(page)")
        }
        do {
            let (data, response) = try await networkClient.request(with: builder)
            guard 200..<300 ~= response.statusCode else { throw ServiceError.notSucessfulResponse }
            let episodePage = try decode(DTO.Page<DTO.Episode>.self, from: data)
            return episodePage
        } catch {
            throw ServiceError.map(from: error)
        }
    }

    func getEpisodes(withIds ids: [Int]) async throws(ServiceError) -> [DTO.Episode] {
        assert(!ids.isEmpty, "ids cannot be empty")
        let builder = RequestBuilder(base: baseURL)
        let idsString = ids.map(String.init).joined(separator: ",")
        builder.setPath("episode/\(idsString)")
        do {
            let (data, response) = try await networkClient.request(with: builder)
            guard 200..<300 ~= response.statusCode else { throw ServiceError.notSucessfulResponse }
            let episodes = try decode([DTO.Episode].self, from: data)
            return episodes
        } catch {
            throw ServiceError.map(from: error)
        }
    }

    func getEpisode(withId id: Int) async throws(ServiceError) -> DTO.Episode {
        assert(id > 0, "id must be greater than zero")
        let builder = RequestBuilder(base: baseURL)
        builder.setPath("episode/\(id)")
        do {
            let (data, response) = try await networkClient.request(with: builder)
            guard 200..<300 ~= response.statusCode else { throw ServiceError.notSucessfulResponse }
            let episode = try decode(DTO.Episode.self, from: data)
            return episode
        } catch {
            throw ServiceError.map(from: error)
        }
    }
}
