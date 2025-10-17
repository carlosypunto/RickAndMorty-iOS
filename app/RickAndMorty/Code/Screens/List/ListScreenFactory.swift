// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import SwiftUI
import RickAndMortyDomain
import RickAndMortyData

struct ListScreenFactory {
    static func view(container: AppContainer = DefaultContainer()) -> some View {
        ListScreen(viewModel: .init(getCharactersPageUseCase: container.getCharactersPage))
    }
}
