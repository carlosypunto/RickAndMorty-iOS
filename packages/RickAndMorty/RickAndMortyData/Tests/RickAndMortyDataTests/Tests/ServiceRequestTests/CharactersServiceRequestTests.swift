// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import Testing
import NetworkClient
@testable import RickAndMortyData

struct CharactersServiceRequestTests {
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

    // MARK: - response error

    @Test func test_getCharacters_firstPage_responseError() async {
        let client = NetworkClientErrorSpy()
        let sut = RickAndMortyServicesImpl(networkClient: client)
        do {
            _ = try await sut.getCharacters(page: 1)
        } catch {
            #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/character")
            #expect(ServiceError.notSuccessfulResponse(statusCode: 500) == error)
            return
        }
        Issue.record("A ServiceError was expected.")
    }

    @Test func test_getCharacters_responseError() async {
        let client = NetworkClientErrorSpy()
        let sut = RickAndMortyServicesImpl(networkClient: client)
        let page = Int.random(in: 2..<50)
        do {
            _ = try await sut.getCharacters(page: page)
        } catch {
            #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/character?page=\(page)")
            #expect(ServiceError.notSuccessfulResponse(statusCode: 500) == error)
            return
        }
        Issue.record("A ServiceError was expected.")
    }

    @Test func test_getCharacters_withIds_responseError() async {
        let client = NetworkClientErrorSpy()
        let sut = RickAndMortyServicesImpl(networkClient: client)
        let ids = [Int].randomIds().sorted()

        do {
            _ = try await sut.getCharacters(withIds: ids)
        } catch {
            let idsString = ids.map(String.init).joined(separator: ",")
            #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/character/\(idsString)")
            #expect(ServiceError.notSuccessfulResponse(statusCode: 500) == error)
            return
        }
        Issue.record("A ServiceError was expected.")
    }

    @Test func test_getCharacter_withId_responseError() async {
        let client = NetworkClientErrorSpy()
        let sut = RickAndMortyServicesImpl(networkClient: client)
        let id = Int.random(in: 1..<100)
        do {
            _ = try await sut.getCharacter(withId: id)
        } catch {
            #expect(client.requestedUrlAbsoluteString == "https://rickandmortyapi.com/api/character/\(id)")
            #expect(ServiceError.notSuccessfulResponse(statusCode: 500) == error)
            return
        }
        Issue.record("A ServiceError was expected.")
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
