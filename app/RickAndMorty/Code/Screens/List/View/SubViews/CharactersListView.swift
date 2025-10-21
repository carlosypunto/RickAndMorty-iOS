// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import SwiftUI

extension ListScreen {
    struct CharactersListView: View {
        @State private var charactersRouter = CharactersRouter()
        @Environment(ListScreenViewModel.self) private var viewModel

        var body: some View {
            NavigationStack {
                List {
                    ForEach(viewModel.characters) { character in
                        NavigationLink(value: CharactersRoute.toDetail(character)) {
                            CharacterCell(character: character)
                                .accessibilityLabel(character.accessibilityLabel)
                        }
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
                .environment(charactersRouter)
                .navigationDestination(
                    for: CharactersRoute.self,
                    destination: charactersRouter.makeDestination
                )
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
