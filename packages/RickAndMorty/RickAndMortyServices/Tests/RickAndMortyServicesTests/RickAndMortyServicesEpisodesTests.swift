// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import Testing
import NetworkClient
@testable import RickAndMortyServices

struct RickAndMortyServicesEpisodesTests {
    @Test func test_getEpisodes_firstPage_requestUrl() async {
        let client = NetworkClientSpy(data: Data())
        let sut = RickAndMortyServicesImpl(networkClient: client)
        _ = try! await sut.getEpisodes(page: 1)
        #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/episode")
    }

    @Test func test_getEpisodes_requestUrl() async {
        let client = NetworkClientSpy(data: Data())
        let sut = RickAndMortyServicesImpl(networkClient: client)
        let page = Int.random(in: 2..<50)
        _ = try! await sut.getEpisodes(page: page)
        #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/episode?page=\(page)")
    }

    @Test func test_getEpisodes_withIds_requestUrl() async {
        let client = NetworkClientSpy(data: Data())
        let sut = RickAndMortyServicesImpl(networkClient: client)
        let ids = [Int].randomIds().sorted()
        _ = try! await sut.getEpisodes(withIds: ids)
        let idsString = ids.map(String.init).joined(separator: ",")
        #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/episode/\(idsString)")
    }

    @Test func test_getEpisode_withId_requestUrl() async {
        let client = NetworkClientSpy(data: Data())
        let sut = RickAndMortyServicesImpl(networkClient: client)
        let id = Int.random(in: 1..<100)
        _ = try! await sut.getEpisode(withId: id)
        #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/episode/\(id)")

    }
}
