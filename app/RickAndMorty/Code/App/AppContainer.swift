// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import RickAndMortyDomain
import RickAndMortyData

protocol AppContainer {
    var repository: RickAndMortyRepository { get }
    var getCharactersPage: GetCharactersPageUseCase { get }
}

struct DefaultContainer: AppContainer {
    let repository: RickAndMortyRepository = RickAndMortyRepositoryImpl()
    var getCharactersPage: GetCharactersPageUseCase {
        GetCharactersPageUseCaseImpl(repository: repository)
    }
}
