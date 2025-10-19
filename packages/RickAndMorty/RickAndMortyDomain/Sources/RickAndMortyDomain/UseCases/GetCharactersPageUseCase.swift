// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

public protocol GetCharactersPageUseCase: Sendable {
    func execute(page: Int) async throws(RepositoryError) -> Page<Character>
}

public final class GetCharactersPageUseCaseImpl: GetCharactersPageUseCase, Sendable {
    let repository: CharactersRepository

    public init(repository: CharactersRepository) {
        self.repository = repository
    }

    public func execute(page: Int) async throws(RepositoryError) -> Page<Character> {
        try await repository.getCharacters(page: page)
    }
}
