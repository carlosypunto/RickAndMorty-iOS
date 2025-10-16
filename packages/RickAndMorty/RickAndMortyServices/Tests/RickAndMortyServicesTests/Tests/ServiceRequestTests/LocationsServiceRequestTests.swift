// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import Testing
import NetworkClient
@testable import RickAndMortyServices

struct LocationsServiceRequestTests {
    @Test func test_getLocations_firstPage_requestUrl() async {
        let client = NetworkClientSpy(data: DTOLocationsJSONStubs.locationPageData)
        let sut = RickAndMortyServicesImpl(networkClient: client)
        _ = try! await sut.getLocations(page: 1)
        #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/location")
    }

    @Test func test_getLocations_requestUrl() async {
        let client = NetworkClientSpy(data: DTOLocationsJSONStubs.locationPageData)
        let sut = RickAndMortyServicesImpl(networkClient: client)
        let page = Int.random(in: 2..<50)
        _ = try! await sut.getLocations(page: page)
        #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/location?page=\(page)")
    }

    @Test func test_getLocations_withIds_requestUrl() async {
        let client = NetworkClientSpy(data: DTOLocationsJSONStubs.locationListData)
        let sut = RickAndMortyServicesImpl(networkClient: client)
        let ids = [Int].randomIds().sorted()
        _ = try! await sut.getLocations(withIds: ids)
        let idsString = ids.map(String.init).joined(separator: ",")
        #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/location/\(idsString)")
    }

    @Test func test_getLocation_withId_requestUrl() async {
        let client = NetworkClientSpy(data: DTOLocationsJSONStubs.locationOneData)
        let sut = RickAndMortyServicesImpl(networkClient: client)
        let id = Int.random(in: 1..<100)
        _ = try! await sut.getLocation(withId: id)
        #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/location/\(id)")

    }

    // MARK: - response error

    @Test func test_getLocations_firstPage_responseError() async {
        let client = NetworkClientErrorSpy()
        let sut = RickAndMortyServicesImpl(networkClient: client)
        do {
            _ = try await sut.getLocations(page: 1)
        } catch {
            #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/location")
            #expect(ServiceError.notSuccessfulResponse(statusCode: 500) == error)
            return
        }
        Issue.record("A ServiceError was expected.")
    }

    @Test func test_getLocations_responseError() async {
        let client = NetworkClientErrorSpy()
        let sut = RickAndMortyServicesImpl(networkClient: client)
        let page = Int.random(in: 2..<50)
        do {
            _ = try await sut.getLocations(page: page)
        } catch {
            #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/location?page=\(page)")
            #expect(ServiceError.notSuccessfulResponse(statusCode: 500) == error)
            return
        }
        Issue.record("A ServiceError was expected.")
    }

    @Test func test_getLocations_withIds_responseError() async {
        let client = NetworkClientErrorSpy()
        let sut = RickAndMortyServicesImpl(networkClient: client)
        let ids = [Int].randomIds().sorted()

        do {
            _ = try await sut.getLocations(withIds: ids)
        } catch {
            let idsString = ids.map(String.init).joined(separator: ",")
            #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/location/\(idsString)")
            #expect(ServiceError.notSuccessfulResponse(statusCode: 500) == error)
            return
        }
        Issue.record("A ServiceError was expected.")
    }

    @Test func test_getLocation_withId_responseError() async {
        let client = NetworkClientErrorSpy()
        let sut = RickAndMortyServicesImpl(networkClient: client)
        let id = Int.random(in: 1..<100)
        do {
            _ = try await sut.getLocation(withId: id)
        } catch {
            #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/location/\(id)")
            #expect(ServiceError.notSuccessfulResponse(statusCode: 500) == error)
            return
        }
        Issue.record("A ServiceError was expected.")
    }

    // MARK: - bad parameters

    @Test func test_getLocations_badParameters() async {
        let sut = RickAndMortyServicesImpl()
        let expectedError = ServiceError.invalidParameter("page must be > 0")

        do {
            _ = try await sut.getLocations(page: -1)
        } catch {
            #expect(expectedError == error, "Unexpected error: \(error)")
        }

        do {
            _ = try await sut.getLocations(page: 0)
        } catch {
            #expect(expectedError == error, "Unexpected error: \(error)")
        }
    }

    @Test func test_getLocations_withIds_badParameters() async {
        let sut = RickAndMortyServicesImpl()
        do {
            _ = try await sut.getLocations(withIds: [])
        } catch {
            let expectedError = ServiceError.invalidParameter("ids must not be empty")
            #expect(expectedError == error, "Unexpected error: \(error)")
        }
    }

    @Test func test_getLocation_withId_badParameters() async {
        let sut = RickAndMortyServicesImpl()
        let expectedError = ServiceError.invalidParameter("id must be > 0")

        do {
            _ = try await sut.getLocation(withId: -1)
        } catch {
            #expect(expectedError == error, "Unexpected error: \(error)")
        }

        do {
            _ = try await sut.getLocation(withId: 0)
        } catch {
            #expect(expectedError == error, "Unexpected error: \(error)")
        }
    }
}
