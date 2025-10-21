// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import SwiftUI

extension ListScreen {
    struct CharactersListView: View {
        @Environment(ListScreenViewModel.self) private var viewModel

        var body: some View {
            NavigationStack {
                List {
                    ForEach(viewModel.characters) { character in
                        CharacterCell(character: character)
                            .accessibilityLabel(character.accessibilityLabel)
                    }

                    if viewModel.canLoadMore, !viewModel.characters.isEmpty {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                        .task {
                            await viewModel.loadNextPage()
                        }
                    }
                }
                .navigationTitle("charactersListScreen.navigationTitle")
            }
        }
    }
}

private extension CharacterUI {
    var accessibilityLabel: String {
        "\(name), \(status)"
    }
}

#Preview {
    ListScreen(viewModel: .init(getCharactersPageUseCase: GetCharactersPageUseCaseStub()))
}
