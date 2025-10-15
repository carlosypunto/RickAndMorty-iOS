// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import NetworkClient

extension RickAndMortyServicesImpl {
    func getCharacters(page: Int) async throws(ServiceError) -> DTO.Page<DTO.Character> {
        assert(page > 0, "page must be greater than zero")
        let builder = RequestBuilder(base: baseURL)
        builder.setPath("character")
        if page > 1 {
            builder.addQueryItem(name: "page", value: "\(page)")
        }
        do {
            let (data, response) = try await networkClient.request(with: builder)
            guard 200..<300 ~= response.statusCode else { throw ServiceError.notSucessfulResponse }
            let characterPage = try decode(DTO.Page<DTO.Character>.self, from: data)
            return characterPage
        } catch {
            throw ServiceError.map(from: error)
        }
    }

    func getCharacters(withIds ids: [Int]) async throws(ServiceError) -> [DTO.Character] {
        assert(!ids.isEmpty, "ids cannot be empty")
        let builder = RequestBuilder(base: baseURL)
        let idsString = ids.map(String.init).joined(separator: ",")
        builder.setPath("character/\(idsString)")
        do {
            let (data, response) = try await networkClient.request(with: builder)
            guard 200..<300 ~= response.statusCode else { throw ServiceError.notSucessfulResponse }
            let characters = try decode([DTO.Character].self, from: data)
            return characters
        } catch {
            throw ServiceError.map(from: error)
        }
    }

    func getCharacter(withId id: Int) async throws(ServiceError) -> DTO.Character {
        assert(id > 0, "id must be greater than zero")
        let builder = RequestBuilder(base: baseURL)
        builder.setPath("character/\(id)")
        do {
            let (data, response) = try await networkClient.request(with: builder)
            guard 200..<300 ~= response.statusCode else { throw ServiceError.notSucessfulResponse }
            let character = try decode(DTO.Character.self, from: data)
            return character
        } catch {
            throw ServiceError.map(from: error)
        }
    }
}
