// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import SwiftUI

extension CharacterDetailScreen {
    struct EpisodesView: View {
        let episodes: [EpisodeUI]

        var body: some View {
            VStack(alignment: .leading) {
                Text("charactersDetailScreen.episodesTitle")
                    .font(.title2)

                ForEach(episodes) { episode in
                    HStack(alignment: .firstTextBaseline) {
                        Text("- \(episode.episode)").textStyle(.label)
                        Text("\(episode.title)").textStyle(.regular)
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
