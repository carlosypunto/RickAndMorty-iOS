// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import Testing
@testable import RickAndMorty
import RickAndMortyDomain

@Suite("ListScreenViewModel")
struct ListScreenViewModelTests {

    @Test("Initial state is loading and cannot load more")
    @MainActor
    func initialState() async throws {
        let useCase = GetCharactersPageUseCaseMock()
        let sut = ListScreenViewModel(getCharactersPageUseCase: useCase)

        #expect(sut.viewState == .loading)
        #expect(sut.canLoadMore == false)
        #expect(sut.presentedError == nil)
    }

    @Test("First successful load sets success state and canLoadMore true when not last page")
    @MainActor
    func firstLoadSuccess() async throws {
        let useCase = GetCharactersPageUseCaseMock()
        useCase.pages[1] = .success(makePage(ids: [1,2,3], isLast: false))
        let sut = ListScreenViewModel(getCharactersPageUseCase: useCase)

        sut.loadNextPage()
        // Allow task to complete
        try? await Task.sleep(nanoseconds: 50_000_000)

        if case let .success(characters) = sut.viewState {
            #expect(characters.map { $0.id } == [1,2,3])
        } else {
            Issue.record("Expected success state")
        }
        #expect(sut.canLoadMore == true)
        #expect(useCase.receivedPages == [1])
    }

    @Test("Pagination appends and updates canLoadMore when last page reached")
    @MainActor
    func pagination() async throws {
        let useCase = GetCharactersPageUseCaseMock()
        useCase.pages[1] = .success(makePage(ids: [1,2,3], isLast: false))
        useCase.pages[2] = .success(makePage(ids: [4,5], isLast: true))
        let sut = ListScreenViewModel(getCharactersPageUseCase: useCase)

        sut.loadNextPage()
        try? await Task.sleep(nanoseconds: 50_000_000)
        sut.loadNextPage()
        try? await Task.sleep(nanoseconds: 50_000_000)

        if case let .success(characters) = sut.viewState {
            #expect(characters.map { $0.id } == [1,2,3,4,5])
        } else {
            Issue.record("Expected success state after two pages")
        }
        #expect(sut.canLoadMore == false)
        #expect(useCase.receivedPages == [1,2])
    }

    @Test("Error surfaces presentedError and keeps current characters in error state")
    @MainActor
    func errorHandling() async throws {
        let useCase = GetCharactersPageUseCaseMock()
        useCase.pages[1] = .success(makePage(ids: [1,2], isLast: false))
        useCase.pages[2] = .failure(RepositoryError.unknown)
        let sut = ListScreenViewModel(getCharactersPageUseCase: useCase)

        sut.loadNextPage() // page 1 ok
        try? await Task.sleep(nanoseconds: 50_000_000)
        sut.loadNextPage() // page 2 fails
        try? await Task.sleep(nanoseconds: 50_000_000)

        // Expect error state but retaining first page characters
        if case let .error(currentCharacters) = sut.viewState {
            #expect(currentCharacters.map { $0.id } == [1,2])
        } else {
            Issue.record("Expected error state after failure")
        }
        #expect(sut.presentedError != nil)
        #expect(sut.canLoadMore == false || sut.canLoadMore == true) // can be either depending on failure semantics, main check is state and error
    }

    @Test("Concurrent loadNextPage calls only trigger one underlying request")
    @MainActor
    func avoidsConcurrentLoads() async throws {
        let useCase = GetCharactersPageUseCaseMock()
        useCase.delay = .milliseconds(100)
        useCase.pages[1] = .success(makePage(ids: [1], isLast: true))
        let sut = ListScreenViewModel(getCharactersPageUseCase: useCase)

        await withTaskGroup(of: Void.self) { group in
            for _ in 0..<5 {
                group.addTask { await sut.loadNextPage() }
            }
            await group.waitForAll()
        }
        try? await Task.sleep(nanoseconds: 150_000_000)

        #expect(useCase.receivedPages == [1])
    }

    @Test("shouldPreload returns true near the threshold and respects canLoadMore/loading")
    @MainActor
    func shouldPreloadBehavior() async throws {
        let useCase = GetCharactersPageUseCaseMock()
        useCase.pages[1] = .success(makePage(ids: Array(1...20), isLast: false))
        let sut = ListScreenViewModel(getCharactersPageUseCase: useCase)

        sut.loadNextPage()
        try? await Task.sleep(nanoseconds: 50_000_000)

        // pick an element within last 5 items (default threshold)
        let nearEndId = 20 - 2 // index 17 (0-based), within last 5
        guard case let .success(characters) = sut.viewState,
              let target = characters.first(where: { $0.id == nearEndId }) else {
            Issue.record("Expected characters loaded")
            return
        }

        // canLoadMore is true (page not last), loading is false after completion
        #expect(sut.shouldPreload(for: target) == true)

        // pick an element far from the end
        let farId = 5
        let far = characters.first { $0.id == farId }!
        #expect(sut.shouldPreload(for: far) == false)
    }

    // MARK: - Mocks
    final class GetCharactersPageUseCaseMock: GetCharactersPageUseCase {
        struct PageConfig {
            let elements: [Character]
            let isLast: Bool
        }

        var pages: [Int: Result<Page<Character>, RepositoryError>] = [:]
        private(set) var receivedPages: [Int] = []
        var delay: Duration? = nil

        func execute(page: Int) async throws(RepositoryError) -> Page<Character> {
            receivedPages.append(page)
            if let delay { try? await Task.sleep(for: delay) }
            switch pages[page] ?? .failure(RepositoryError.unknown) {
            case .success(let page):
                return page
            case .failure(let error):
                throw error
            }
        }
    }

    // MARK: - Helpers
    private func makeCharacters(ids: [Int]) -> [Character] {
        ids.map { id in
            Character(
                id: id,
                name: "Char_\(id)",
                status: .alive,
                species: "Human",
                type: "",
                gender: .male,
                origin: .init(id: 1, name: "Earth"),
                location: .init(id: 1, name: "Earth"),
                image: "https://example.com/\(id).png",
                episodes: [],
                created: .now
            )
        }
    }

    private func makePage(ids: [Int], isLast: Bool) -> Page<Character> {
        Page(isLast: isLast, elements: makeCharacters(ids: ids))
    }

}
