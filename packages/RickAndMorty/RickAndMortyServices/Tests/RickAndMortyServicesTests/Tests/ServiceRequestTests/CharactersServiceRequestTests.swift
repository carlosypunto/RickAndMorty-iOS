// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import Testing
import NetworkClient
@testable import RickAndMortyServices

struct CharactersServiceRequestTests {
    // make a real call
    @Test func test_getCharacters_firstPage_requestUrl_real() async {
        let sut = RickAndMortyServicesImpl()
        let salida = try! await sut.getCharacters(page: 1)
        print(salida.toDomain.elements)
        #expect(salida.info.count == 826)
    }

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

    // MARK: - bad parameters

    @Test func test_getCharacters_badParameters() async {
        let sut = RickAndMortyServicesImpl()
        let expectedError = ServiceError.invalidParameter("page must be > 0")

        do {
            _ = try await sut.getCharacters(page: -1)
        } catch {
            #expect(expectedError == error, "Unexpected error: \(error)")
        }

        do {
            _ = try await sut.getCharacters(page: 0)
        } catch {
            #expect(expectedError == error, "Unexpected error: \(error)")
        }
    }

    @Test func test_getCharacters_withIds_badParameters() async {
        let sut = RickAndMortyServicesImpl()
        do {
            _ = try await sut.getCharacters(withIds: [])
        } catch {
            let expectedError = ServiceError.invalidParameter("ids must not be empty")
            #expect(expectedError == error, "Unexpected error: \(error)")
        }
    }

    @Test func test_getCharacter_withId_badParameters() async {
        let sut = RickAndMortyServicesImpl()
        let expectedError = ServiceError.invalidParameter("id must be > 0")

        do {
            _ = try await sut.getCharacter(withId: -1)
        } catch {
            #expect(expectedError == error, "Unexpected error: \(error)")
        }

        do {
            _ = try await sut.getCharacter(withId: 0)
        } catch {
            #expect(expectedError == error, "Unexpected error: \(error)")
        }
    }
}
