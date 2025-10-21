// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

public protocol GetEpisodesByIdsUseCase: Sendable {
    func execute(ids: [Int]) async throws(RepositoryError) -> [Episode]
}

public final class GetEpisodesByIdsUseCaseImpl: GetEpisodesByIdsUseCase, Sendable {
    let repository: EpisodesRepository

    public init(repository: EpisodesRepository) {
        self.repository = repository
    }

    public func execute(ids: [Int]) async throws(RepositoryError) -> [Episode] {
        try await repository.getEpisodes(withIds: ids)
    }
}
