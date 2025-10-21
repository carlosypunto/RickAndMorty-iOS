// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import RickAndMortyDomain
import RickAndMortyData

protocol AppContainer {
    var repository: RickAndMortyRepository { get }
    var getCharactersPage: GetCharactersPageUseCase { get }
    var getEpisodesByIds: GetEpisodesByIdsUseCase { get }
}

struct DefaultContainer: AppContainer {
    static let repository: RickAndMortyRepository = RickAndMortyRepositoryImpl()
    var repository: RickAndMortyRepository { Self.repository }

    var getCharactersPage: GetCharactersPageUseCase {
        GetCharactersPageUseCaseImpl(repository: Self.repository)
    }

    var getEpisodesByIds: GetEpisodesByIdsUseCase {
        GetEpisodesByIdsUseCaseImpl(repository: Self.repository)
    }
}
