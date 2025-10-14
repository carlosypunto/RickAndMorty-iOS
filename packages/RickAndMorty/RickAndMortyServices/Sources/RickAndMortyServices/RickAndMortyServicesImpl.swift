// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import NetworkClient

public final class RickAndMortyServicesImpl: RickAndMortyServices {
    let baseURL = URL(string: "https://rickandmortyapi.com/api")!
    let networkClient: NetworkClient

    init(networkClient: NetworkClient = NetworkClientImpl()) {
        self.networkClient = networkClient
    }

    public func getCharacters(page: Int) async throws(ServiceError) -> Data {
        assert(page > 0, "page must be greater than zero")
        let builder = RequestBuilder(base: baseURL)
        builder.setPath("character")
        if page > 1 {
            builder.addQueryItem(name: "page", value: "\(page)")
        }
        do {
            let (data, response) = try await networkClient.request(with: builder)
            guard 200..<300 ~= response.statusCode else { throw ServiceError.notSucessfulResponse }
            return data
        } catch {
            throw ServiceError.map(from: error)
        }
    }

    public func getLocations(page: Int) async throws(ServiceError) -> Data {
        assert(page > 0, "page must be greater than zero")
        let builder = RequestBuilder(base: baseURL)
        builder.setPath("location")
        if page > 1 {
            builder.addQueryItem(name: "page", value: "\(page)")
        }
        do {
            let (data, response) = try await networkClient.request(with: builder)
            guard 200..<300 ~= response.statusCode else { throw ServiceError.notSucessfulResponse }
            return data
        } catch {
            throw ServiceError.map(from: error)
        }
    }

    public func getEpisodes(page: Int) async throws(ServiceError) -> Data {
        assert(page > 0, "page must be greater than zero")
        let builder = RequestBuilder(base: baseURL)
        builder.setPath("episode")
        if page > 1 {
            builder.addQueryItem(name: "page", value: "\(page)")
        }
        do {
            let (data, response) = try await networkClient.request(with: builder)
            guard 200..<300 ~= response.statusCode else { throw ServiceError.notSucessfulResponse }
            return data
        } catch {
            throw ServiceError.map(from: error)
        }
    }

    public func getCharacter(withId id: Int) async throws(ServiceError) -> Data {
        assert(id > 0, "id must be greater than zero")
        let builder = RequestBuilder(base: baseURL)
        builder.setPath("character/\(id)")
        do {
            let (data, response) = try await networkClient.request(with: builder)
            guard 200..<300 ~= response.statusCode else { throw ServiceError.notSucessfulResponse }
            return data
        } catch {
            throw ServiceError.map(from: error)
        }
    }

    public func getLocation(withId id: Int) async throws(ServiceError) -> Data {
        assert(id > 0, "id must be greater than zero")
        let builder = RequestBuilder(base: baseURL)
        builder.setPath("location/\(id)")
        do {
            let (data, response) = try await networkClient.request(with: builder)
            guard 200..<300 ~= response.statusCode else { throw ServiceError.notSucessfulResponse }
            return data
        } catch {
            throw ServiceError.map(from: error)
        }
    }

    public func getEpisode(withId id: Int) async throws(ServiceError) -> Data {
        assert(id > 0, "id must be greater than zero")
        let builder = RequestBuilder(base: baseURL)
        builder.setPath("episode/\(id)")
        do {
            let (data, response) = try await networkClient.request(with: builder)
            guard 200..<300 ~= response.statusCode else { throw ServiceError.notSucessfulResponse }
            return data
        } catch {
            throw ServiceError.map(from: error)
        }
    }
}
