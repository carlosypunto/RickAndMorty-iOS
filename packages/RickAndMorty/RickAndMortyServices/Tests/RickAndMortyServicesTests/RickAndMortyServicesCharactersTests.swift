// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import Testing
import NetworkClient
@testable import RickAndMortyServices

struct RickAndMortyServicesCharactersTests {
    @Test func test_getCharacters_firstPage_requestUrl() async {
        let client = NetworkClientSpy(data: Data())
        let sut = RickAndMortyServicesImpl(networkClient: client)
        _ = try! await sut.getCharacters(page: 1)
        #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/character")
    }

    @Test func test_getCharacters_requestUrl() async {
        let client = NetworkClientSpy(data: Data())
        let sut = RickAndMortyServicesImpl(networkClient: client)
        let page = Int.random(in: 2..<50)
        _ = try! await sut.getCharacters(page: page)
        #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/character?page=\(page)")
    }

    @Test func test_getCharacter_withId_requestUrl() async {
        let client = NetworkClientSpy(data: Data())
        let sut = RickAndMortyServicesImpl(networkClient: client)
        let id = Int.random(in: 1..<100)
        _ = try! await sut.getCharacter(withId: id)
        #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/character/\(id)")
    }
}
