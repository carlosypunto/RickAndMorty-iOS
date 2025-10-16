// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import Testing
import NetworkClient
@testable import RickAndMortyData

struct EpisodesServiceRequestTests {
    @Test func test_getEpisodes_firstPage_requestUrl() async {
        let client = NetworkClientSpy(data: DTOEpisodesJSONStubs.episodePageData)
        let sut = RickAndMortyServicesImpl(networkClient: client)
        _ = try! await sut.getEpisodes(page: 1)
        #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/episode")
    }

    @Test func test_getEpisodes_requestUrl() async {
        let client = NetworkClientSpy(data: DTOEpisodesJSONStubs.episodePageData)
        let sut = RickAndMortyServicesImpl(networkClient: client)
        let page = Int.random(in: 2..<50)
        _ = try! await sut.getEpisodes(page: page)
        #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/episode?page=\(page)")
    }

    @Test func test_getEpisodes_withIds_requestUrl() async {
        let client = NetworkClientSpy(data: DTOEpisodesJSONStubs.episodeListData)
        let sut = RickAndMortyServicesImpl(networkClient: client)
        let ids = [Int].randomIds().sorted()
        _ = try! await sut.getEpisodes(withIds: ids)
        let idsString = ids.map(String.init).joined(separator: ",")
        #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/episode/\(idsString)")
    }

    @Test func test_getEpisode_withId_requestUrl() async {
        let client = NetworkClientSpy(data: DTOEpisodesJSONStubs.episodeOneData)
        let sut = RickAndMortyServicesImpl(networkClient: client)
        let id = Int.random(in: 1..<100)
        _ = try! await sut.getEpisode(withId: id)
        #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/episode/\(id)")

    }

    // MARK: - response error

    @Test func test_getEpisodes_firstPage_responseError() async {
        let client = NetworkClientErrorSpy()
        let sut = RickAndMortyServicesImpl(networkClient: client)
        do {
            _ = try await sut.getEpisodes(page: 1)
        } catch {
            #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/episode")
            #expect(ServiceError.notSuccessfulResponse(statusCode: 500) == error)
            return
        }
        Issue.record("A ServiceError was expected.")
    }

    @Test func test_getEpisodes_responseError() async {
        let client = NetworkClientErrorSpy()
        let sut = RickAndMortyServicesImpl(networkClient: client)
        let page = Int.random(in: 2..<50)
        do {
            _ = try await sut.getEpisodes(page: page)
        } catch {
            #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/episode?page=\(page)")
            #expect(ServiceError.notSuccessfulResponse(statusCode: 500) == error)
            return
        }
        Issue.record("A ServiceError was expected.")
    }

    @Test func test_getEpisodes_withIds_responseError() async {
        let client = NetworkClientErrorSpy()
        let sut = RickAndMortyServicesImpl(networkClient: client)
        let ids = [Int].randomIds().sorted()

        do {
            _ = try await sut.getEpisodes(withIds: ids)
        } catch {
            let idsString = ids.map(String.init).joined(separator: ",")
            #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/episode/\(idsString)")
            #expect(ServiceError.notSuccessfulResponse(statusCode: 500) == error)
            return
        }
        Issue.record("A ServiceError was expected.")
    }

    @Test func test_getEpisode_withId_responseError() async {
        let client = NetworkClientErrorSpy()
        let sut = RickAndMortyServicesImpl(networkClient: client)
        let id = Int.random(in: 1..<100)
        do {
            _ = try await sut.getEpisode(withId: id)
        } catch {
            #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/episode/\(id)")
            #expect(ServiceError.notSuccessfulResponse(statusCode: 500) == error)
            return
        }
        Issue.record("A ServiceError was expected.")
    }

    // MARK: - bad parameters

    @Test func test_getEpisodes_badParameters() async {
        let sut = RickAndMortyServicesImpl()
        let expectedError = ServiceError.invalidParameter("page must be > 0")

        do {
            _ = try await sut.getEpisodes(page: -1)
        } catch {
            #expect(expectedError == error, "Unexpected error: \(error)")
        }

        do {
            _ = try await sut.getEpisodes(page: 0)
        } catch {
            #expect(expectedError == error, "Unexpected error: \(error)")
        }
    }

    @Test func test_getEpisodes_withIds_badParameters() async {
        let sut = RickAndMortyServicesImpl()
        do {
            _ = try await sut.getEpisodes(withIds: [])
        } catch {
            let expectedError = ServiceError.invalidParameter("ids must not be empty")
            #expect(expectedError == error, "Unexpected error: \(error)")
        }
    }

    @Test func test_getEpisode_withId_badParameters() async {
        let sut = RickAndMortyServicesImpl()
        let expectedError = ServiceError.invalidParameter("id must be > 0")

        do {
            _ = try await sut.getEpisode(withId: -1)
        } catch {
            #expect(expectedError == error, "Unexpected error: \(error)")
        }

        do {
            _ = try await sut.getEpisode(withId: 0)
        } catch {
            #expect(expectedError == error, "Unexpected error: \(error)")
        }
    }
}
