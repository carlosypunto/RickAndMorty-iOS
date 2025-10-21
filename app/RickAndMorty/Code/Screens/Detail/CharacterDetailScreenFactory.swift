// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import SwiftUI
import RickAndMortyDomain
import RickAndMortyData

struct CharacterDetailScreenFactory {
    static func view(
        character: CharacterUI,
        container: AppContainer = DefaultContainer()
    ) -> some View {
        CharacterDetailScreen(
            viewModel: .init(
                character: character,
                getEpisodesByIdsUseCase: container.getEpisodesByIds
            )
        )
    }
}
