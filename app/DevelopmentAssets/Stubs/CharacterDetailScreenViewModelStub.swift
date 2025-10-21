// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

extension CharacterDetailScreenViewModel {
    static func stub(for character: CharacterUI) -> CharacterDetailScreenViewModel {
        .init(
            character: CharacterUIStubs.rickSanchez,
            getEpisodesByIdsUseCase: GetEpisodesByIdsUseCaseStub()
        )
    }
}
