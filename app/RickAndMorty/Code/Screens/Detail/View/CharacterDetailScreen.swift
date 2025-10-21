// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import SwiftUI

struct CharacterDetailScreen: View {
    @State var viewModel: CharacterDetailScreenViewModel

    init(viewModel: CharacterDetailScreenViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                CharacterDetailView()
                    .environment(viewModel)
                    .task {
                        await viewModel.loadEpisodes()
                    }
            }
        }
        .navigationBarTitle(viewModel.character.name, displayMode: .inline)
        .navigationBarColor(backgroundColor: viewModel.character.specieColor)
    }
}

#Preview("Rick Sanchez (Human)") {
    NavigationView {
        CharacterDetailScreen(viewModel: .stub(for: CharacterUIStubs.rickSanchez))
    }
}

#Preview("An Alien") {
    NavigationView {
        CharacterDetailScreen(viewModel: .stub(for: CharacterUIStubs.anAlien))
    }
}

#Preview("An Humanoid") {
    NavigationView {
        CharacterDetailScreen(viewModel: .stub(for: CharacterUIStubs.anHumanoid))
    }
}
