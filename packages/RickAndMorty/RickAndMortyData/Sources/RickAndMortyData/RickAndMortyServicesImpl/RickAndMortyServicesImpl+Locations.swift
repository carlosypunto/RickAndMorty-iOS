// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import NetworkClient

extension RickAndMortyServicesImpl {
    func getLocations(page: Int) async throws(ServiceError) -> DTO.Page<DTO.Location> {
        guard page > 0 else { throw ServiceError.invalidParameter("page must be > 0") }
        let builder = RequestBuilder(base: baseURL)
        builder.setPath("location")
        if page > 1 {
            builder.addQueryItem(name: "page", value: "\(page)")
        }
        do {
            let (data, response) = try await networkClient.request(with: builder)
            guard 200..<300 ~= response.statusCode else { throw ServiceError.notSuccessfulResponse(statusCode: response.statusCode) }
            let locationPage = try decode(DTO.Page<DTO.Location>.self, from: data)
            return locationPage
        } catch {
            throw ServiceError.map(from: error)
        }
    }

    func getLocations(withIds ids: [Int]) async throws(ServiceError) -> [DTO.Location] {
        guard !ids.isEmpty else { throw ServiceError.invalidParameter("ids must not be empty") }
        let builder = RequestBuilder(base: baseURL)
        let idsString = ids.map(String.init).joined(separator: ",")
        builder.setPath("location/\(idsString)")
        do {
            let (data, response) = try await networkClient.request(with: builder)
            guard 200..<300 ~= response.statusCode else { throw ServiceError.notSuccessfulResponse(statusCode: response.statusCode) }
            let locations = try decode([DTO.Location].self, from: data)
            return locations
        } catch {
            throw ServiceError.map(from: error)
        }
    }

    func getLocation(withId id: Int) async throws(ServiceError) -> DTO.Location {
        guard id > 0 else { throw ServiceError.invalidParameter("id must be > 0") }
        let builder = RequestBuilder(base: baseURL)
        builder.setPath("location/\(id)")
        do {
            let (data, response) = try await networkClient.request(with: builder)
            guard 200..<300 ~= response.statusCode else { throw ServiceError.notSuccessfulResponse(statusCode: response.statusCode) }
            let location = try decode(DTO.Location.self, from: data)
            return location
        } catch {
            throw ServiceError.map(from: error)
        }
    }
}
