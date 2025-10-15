// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import Testing
import NetworkClient
@testable import RickAndMortyServices

struct RickAndMortyServicesCharactersTests {
    @Test func test_getCharacters_firstPage_requestUrl() async {
        let client = NetworkClientSpy(data: DTOCharacterJSONStubs.characterPageData)
        let sut = RickAndMortyServicesImpl(networkClient: client)
        _ = try! await sut.getCharacters(page: 1)
        #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/character")
    }

    @Test func test_getCharacters_requestUrl() async {
        let client = NetworkClientSpy(data: DTOCharacterJSONStubs.characterPageData)
        let sut = RickAndMortyServicesImpl(networkClient: client)
        let page = Int.random(in: 2..<50)
        _ = try! await sut.getCharacters(page: page)
        #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/character?page=\(page)")
        #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/character?page=\(page)")
    }

    @Test func test_getCharacters_withIds_requestUrl() async {
        let client = NetworkClientSpy(data: DTOCharacterJSONStubs.characterListData)
        let sut = RickAndMortyServicesImpl(networkClient: client)
        let ids = [Int].randomIds().sorted()
        _ = try! await sut.getCharacters(withIds: ids)
        let idsString = ids.map(String.init).joined(separator: ",")
        #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/character/\(idsString)")
    }

    @Test func test_getCharacter_withId_requestUrl() async {
        let client = NetworkClientSpy(data: DTOCharacterJSONStubs.characterOneData)
        let sut = RickAndMortyServicesImpl(networkClient: client)
        let id = Int.random(in: 1..<100)
        _ = try! await sut.getCharacter(withId: id)
        #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/character/\(id)")
    }
}
