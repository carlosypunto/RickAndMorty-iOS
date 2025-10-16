// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import NetworkClient

extension RickAndMortyServicesImpl {
    func getCharacters(page: Int) async throws(ServiceError) -> DTO.Page<DTO.Character> {
        guard page > 0 else { throw ServiceError.invalidParameter("page must be > 0") }
        let builder = RequestBuilder(base: baseURL)
        builder.setPath("character")
        if page > 1 {
            builder.addQueryItem(name: "page", value: "\(page)")
        }
        do {
            let (data, response) = try await networkClient.request(with: builder)
            guard 200..<300 ~= response.statusCode else { throw ServiceError.notSucessfulResponse(statusCode: response.statusCode) }
            let characterPage = try decode(DTO.Page<DTO.Character>.self, from: data)
            return characterPage
        } catch {
            throw ServiceError.map(from: error)
        }
    }

    func getCharacters(withIds ids: [Int]) async throws(ServiceError) -> [DTO.Character] {
        guard !ids.isEmpty else { throw ServiceError.invalidParameter("ids must not be empty") }
        let builder = RequestBuilder(base: baseURL)
        let idsString = ids.map(String.init).joined(separator: ",")
        builder.setPath("character/\(idsString)")
        do {
            let (data, response) = try await networkClient.request(with: builder)
            guard 200..<300 ~= response.statusCode else { throw ServiceError.notSucessfulResponse(statusCode: response.statusCode) }
            let characters = try decode([DTO.Character].self, from: data)
            return characters
        } catch {
            throw ServiceError.map(from: error)
        }
    }

    func getCharacter(withId id: Int) async throws(ServiceError) -> DTO.Character {
        guard id > 0 else { throw ServiceError.invalidParameter("id must be > 0") }
        let builder = RequestBuilder(base: baseURL)
        builder.setPath("character/\(id)")
        do {
            let (data, response) = try await networkClient.request(with: builder)
            guard 200..<300 ~= response.statusCode else { throw ServiceError.notSucessfulResponse(statusCode: response.statusCode) }
            let character = try decode(DTO.Character.self, from: data)
            return character
        } catch {
            throw ServiceError.map(from: error)
        }
    }
}
