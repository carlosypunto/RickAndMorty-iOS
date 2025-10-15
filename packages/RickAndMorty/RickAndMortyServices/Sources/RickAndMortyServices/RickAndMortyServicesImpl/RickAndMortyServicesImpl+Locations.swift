// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import NetworkClient

extension RickAndMortyServicesImpl {
    func getLocations(page: Int) async throws(ServiceError) -> DTO.Page<DTO.Location> {
        assert(page > 0, "page must be greater than zero")
        let builder = RequestBuilder(base: baseURL)
        builder.setPath("location")
        if page > 1 {
            builder.addQueryItem(name: "page", value: "\(page)")
        }
        do {
            let (data, response) = try await networkClient.request(with: builder)
            guard 200..<300 ~= response.statusCode else { throw ServiceError.notSucessfulResponse }
            let locationPage = try decode(DTO.Page<DTO.Location>.self, from: data)
            return locationPage
        } catch {
            throw ServiceError.map(from: error)
        }
    }

    func getLocations(withIds ids: [Int]) async throws(ServiceError) -> [DTO.Location] {
        assert(!ids.isEmpty, "ids cannot be empty")
        let builder = RequestBuilder(base: baseURL)
        let idsString = ids.map(String.init).joined(separator: ",")
        builder.setPath("location/\(idsString)")
        do {
            let (data, response) = try await networkClient.request(with: builder)
            guard 200..<300 ~= response.statusCode else { throw ServiceError.notSucessfulResponse }
            let locations = try decode([DTO.Location].self, from: data)
            return locations
        } catch {
            throw ServiceError.map(from: error)
        }
    }

    func getLocation(withId id: Int) async throws(ServiceError) -> DTO.Location {
        assert(id > 0, "id must be greater than zero")
        let builder = RequestBuilder(base: baseURL)
        builder.setPath("location/\(id)")
        do {
            let (data, response) = try await networkClient.request(with: builder)
            guard 200..<300 ~= response.statusCode else { throw ServiceError.notSucessfulResponse }
            let location = try decode(DTO.Location.self, from: data)
            return location
        } catch {
            throw ServiceError.map(from: error)
        }
    }
}
