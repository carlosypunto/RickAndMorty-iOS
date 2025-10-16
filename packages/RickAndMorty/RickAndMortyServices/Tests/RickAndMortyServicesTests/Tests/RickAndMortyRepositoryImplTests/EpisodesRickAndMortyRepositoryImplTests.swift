// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import RickAndMortyDomain
import Testing

@testable import RickAndMortyServices

struct EpisodesRickAndMortyRepositoryImplTests {
    @Test func test_getEpisodes_firstPage_parameters() async {
        let services = RickAndMortyServicesSpy()
        let sut = RickAndMortyRepositoryImpl(services: services)
        _ = try! await sut.getEpisodes(page: 1)
        #expect(services.requestedPage == 1)
    }

    @Test func test_getEpisodes_parameters() async {
        let services = RickAndMortyServicesSpy()
        let sut = RickAndMortyRepositoryImpl(services: services)
        let page = Int.random(in: 2 ..< 50)
        _ = try! await sut.getEpisodes(page: page)
        #expect(services.requestedPage == page)
    }

    @Test func test_getEpisodes_withIds_parameters() async {
        let services = RickAndMortyServicesSpy()
        let sut = RickAndMortyRepositoryImpl(services: services)
        let ids = [Int].randomIds().sorted()
        _ = try! await sut.getEpisodes(withIds: ids)
        #expect(services.requestedIds == ids)
    }

    @Test func test_getEpisode_withId_parameters() async {
        let services = RickAndMortyServicesSpy()
        let sut = RickAndMortyRepositoryImpl(services: services)
        let id = Int.random(in: 1 ..< 100)
        _ = try! await sut.getEpisode(withId: id)
        #expect(services.requestedId == id)
    }

    // MARK: - bad parameters

    @Test func test_getEpisodes_badParameters() async {
        let sut = RickAndMortyRepositoryImpl()
        let expectedError = RepositoryError.invalidParameter("page must be > 0")

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
        let sut = RickAndMortyRepositoryImpl()
        do {
            _ = try await sut.getEpisodes(withIds: [])
        } catch {
            let expectedError = RepositoryError.invalidParameter("ids must not be empty")
            #expect(expectedError == error, "Unexpected error: \(error)")
        }
    }

    @Test func test_getEpisode_withId_badParameters() async {
        let sut = RickAndMortyRepositoryImpl()
        let expectedError = RepositoryError.invalidParameter("id must be > 0")

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
