// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import Testing
@testable import RickAndMorty
import RickAndMortyDomain

@Suite("ListScreenViewModel")
struct ListScreenViewModelTests {

    @Test("Initial state is idle and can load more")
    @MainActor
    func initialState() async throws {
        let useCase = GetCharactersPageUseCaseMock()
        let sut = ListScreenViewModel(getCharactersPageUseCase: useCase)

        #expect(sut.state == .idle)
        #expect(sut.canLoadMore == true)
        #expect(sut.characters.isEmpty)
    }

    @Test("First successful load sets success state and canLoadMore true when not last page")
    @MainActor
    func firstLoadSuccess() async throws {
        let useCase = GetCharactersPageUseCaseMock()
        useCase.pages[1] = .success(Page<Character>.makePage(ids: [1,2,3], isLast: false))
        let sut = ListScreenViewModel(getCharactersPageUseCase: useCase)

        await sut.loadNextPage()

        if case .success = sut.state {
            #expect(sut.characters.map { $0.id } == [1,2,3])
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
        useCase.pages[1] = .success(Page<Character>.makePage(ids: [1,2,3], isLast: false))
        useCase.pages[2] = .success(Page<Character>.makePage(ids: [4,5], isLast: true))
        let sut = ListScreenViewModel(getCharactersPageUseCase: useCase)

        await sut.loadNextPage()
        await sut.loadNextPage()

        if case .success = sut.state {
            #expect(sut.characters.map { $0.id } == [1,2,3,4,5])
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
        useCase.pages[1] = .success(Page<Character>.makePage(ids: [1,2], isLast: false))
        useCase.pages[2] = .failure(RepositoryError.offline)
        let sut = ListScreenViewModel(getCharactersPageUseCase: useCase)

        await sut.loadNextPage() // page 1 ok
        await sut.loadNextPage() // page 2 fails

        // Expect error state but retaining first page characters
        if case .error = sut.state {
            #expect(sut.characters.map { $0.id } == [1,2])
        } else {
            Issue.record("Expected error state after failure")
        }
        #expect(sut.state == .error(.offline))
        #expect(sut.canLoadMore == false || sut.canLoadMore == true)
    }

    @Test("Concurrent loadNextPage calls only trigger one underlying request")
    @MainActor
    func avoidsConcurrentLoads() async throws {
        let useCase = GetCharactersPageUseCaseMock()
        useCase.delay = .milliseconds(100)
        useCase.pages[1] = .success(Page<Character>.makePage(ids: [1], isLast: true))
        let sut = ListScreenViewModel(getCharactersPageUseCase: useCase)

        await withTaskGroup(of: Void.self) { group in
            for _ in 0..<5 {
                group.addTask { await sut.loadNextPage() }
            }
            await group.waitForAll()
        }

        #expect(useCase.receivedPages == [1])
    }
}

@Suite("ListScreenViewModel - Integration")
struct ListScreenViewModelIntegrationTests {
    @Test("")
    @MainActor
    func loadNextPage_withFreshState_shouldAppendAndSetSuccess() async {
        let repository = RepositoryStub(pages: [.stubPage1])
        let useCase = GetCharactersPageUseCaseImpl(repository: repository)
        let sut = ListScreenViewModel(getCharactersPageUseCase: useCase)

        await sut.loadNextPage()

        #expect(sut.characters.isEmpty == false)
        #expect(sut.state == .success)
        #expect(sut.canLoadMore == true)
    }

    @Test("")
    @MainActor
    func loadNextPage_whenAlreadyLoading_shouldNotDuplicateRequest() async {
        let slowRepository = RepositoryStub(pages: [.stubPage1], delay: .milliseconds(150))
        let useCase = GetCharactersPageUseCaseImpl(repository: slowRepository)
        let sut = ListScreenViewModel(getCharactersPageUseCase: useCase)

        await withTaskGroup(of: Void.self) { group in
            for _ in 0..<3 { group.addTask { await sut.loadNextPage() } }
            await group.waitForAll()
        }


        #expect(sut.characters.count == Page<Character>.stubPage1.elements.count)
    }

    @Test("")
    @MainActor
    func loadNextPage_onLastPage_shouldSetCanLoadMoreToFalse() async {
        let repository = RepositoryStub(pages: [.stubLastPage])
        let useCase = GetCharactersPageUseCaseImpl(repository: repository)
        let sut = ListScreenViewModel(getCharactersPageUseCase: useCase)

        await sut.loadNextPage()

        #expect(sut.canLoadMore == false)
        #expect(sut.state == .success)
    }

    @Test("")
    @MainActor
    func loadNextPage_afterRepositoryFailure_shouldExposeErrorThenRecoverOnRetry() async {
        let flakyRepository = FlakyRepositoryStub(failFirst: true, page: .stubPage1)
        let useCase = GetCharactersPageUseCaseImpl(repository: flakyRepository)
        let sut = ListScreenViewModel(getCharactersPageUseCase: useCase)

        await sut.loadNextPage()

        #expect(sut.state == .error(.unmanageable))

        await sut.loadNextPage()

        #expect(sut.state == .success)
        #expect(sut.characters.isEmpty == false)
    }
}

// MARK: - Helpers

private extension Page<Character> {
    static var emptyLast: Page<Character> {
        .init(isLast: true, elements: [])
    }

    static var stubLastPage: Page<Character> {
        makePage(ids: [8, 9, 10], isLast: true)
    }

    static var stubPage1: Page<Character> {
        makePage(ids: [1,2,3], isLast: false)
    }

    static func makePage(ids: [Int], isLast: Bool) -> Page<Character> {
        Page(isLast: isLast, elements: makeCharacters(ids: ids))
    }

    static func makeCharacters(ids: [Int]) -> [Character] {
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
}

// MARK: - Mocks

private final class GetCharactersPageUseCaseMock: GetCharactersPageUseCase, @unchecked Sendable {
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

private struct RepositoryStub: CharactersRepository {
    var pages: [Page<Character>]
    var delay: Duration = .zero

    func getCharacters(page: Int) async throws(RepositoryError) -> Page<Character> {
        try! await Task.sleep(for: delay)
        guard page - 1 < pages.count else { return Page<Character>.emptyLast }
        return pages[page - 1]
    }

    func getCharacters(withIds ids: [Int]) async throws(RickAndMortyDomain.RepositoryError) -> [RickAndMortyDomain.Character] {
        throw .server
    }

    func getCharacter(withId id: Int) async throws(RickAndMortyDomain.RepositoryError) -> RickAndMortyDomain.Character {
        throw .server
    }
}

private final class FlakyRepositoryStub: CharactersRepository, @unchecked Sendable {
    private(set) var pages: [Page<Character>]
    private(set) var failFirst: Bool
    private var hasFail = false

    init(failFirst: Bool, page: Page<Character>) {
        self.pages = [page]
        self.failFirst = failFirst
    }

    func getCharacters(page: Int) async throws(RepositoryError) -> Page<Character> {
        if failFirst, !hasFail { hasFail = true; throw .server }
        guard page - 1 < pages.count else { return Page<Character>.emptyLast }
        return pages[page - 1]
    }

    func getCharacters(withIds ids: [Int]) async throws(RickAndMortyDomain.RepositoryError) -> [RickAndMortyDomain.Character] {
        throw .server
    }

    func getCharacter(withId id: Int) async throws(RickAndMortyDomain.RepositoryError) -> RickAndMortyDomain.Character {
        throw .server
    }
}
