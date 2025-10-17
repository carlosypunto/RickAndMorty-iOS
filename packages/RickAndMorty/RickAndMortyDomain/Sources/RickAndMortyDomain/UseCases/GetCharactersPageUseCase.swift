// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

public final class GetCharactersPageUseCase {
    var repository: RickAndMortyRepository

    public init(repository: RickAndMortyRepository) {
        self.repository = repository
    }

    public func execute(page: Int) async throws(RepositoryError) -> Page<Character> {
        try await repository.getCharacters(page: page)
    }
}
