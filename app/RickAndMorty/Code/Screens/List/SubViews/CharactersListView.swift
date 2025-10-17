// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import SwiftUI

struct CharactersListView: View {
    private let characters: [CharacterUI]
    private let viewModel: ListScreenViewModel

    init(characters: [CharacterUI], viewModel: ListScreenViewModel) {
        self.characters = characters
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(characters) { character in
                    CharacterCell(character: character)
                        .accessibilityLabel(character.accessibilityLabel)
                        .onAppear {
                            if viewModel.shouldPreload(for: character) {
                                viewModel.loadNextPage()
                            }
                        }
                }
                if viewModel.canLoadMore {
                    ProgressView()
                        .onAppear { viewModel.loadNextPage() }
                }
            }
            .listStyle(.inset)
            .navigationTitle("charactersListScreen.navigationTitle")
        }
    }
}

extension CharacterUI {
    var accessibilityLabel: String {
        "\(name), \(status)"
    }
}
