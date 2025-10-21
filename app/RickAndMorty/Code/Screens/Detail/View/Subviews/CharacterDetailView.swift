// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import SwiftUI
import UIComponents

extension CharacterDetailScreen {
    struct CharacterDetailView: View {
        @Environment(CharacterDetailScreenViewModel.self) private var viewModel

        var body: some View {
            VStack(alignment: .leading) {
                AsyncCachedImage(
                    url: URL(string: viewModel.character.image)!,
                    content: { image in
                        image
                            .resizable()
                    },
                    placeholder: {
                        Image("placeholder")
                            .resizable()
                    }
                )
                .aspectRatio(1.0, contentMode: .fit)

                CharacteristicsView(character: viewModel.character)
                    .padding(.top)
                    .padding(.horizontal)

                switch viewModel.state {
                case .idle, .loading, .error:
                    EmptyView()
                case .success:
                    if !viewModel.episodes.isEmpty {
                        ScrollView {
                            EpisodesView(episodes: viewModel.episodes)
                                .padding(.horizontal)
                        }
                    }
                }

                Spacer()
            }
        }
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
