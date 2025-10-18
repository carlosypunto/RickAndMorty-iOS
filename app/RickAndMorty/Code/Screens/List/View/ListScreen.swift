// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import SwiftUI

struct ListScreen: View {
    @State var viewModel: ListScreenViewModel
    @State var presentedError: ScreenError?

    init(viewModel: ListScreenViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading where viewModel.characters.isEmpty:
                LoaderView()
            case .error(let error) where viewModel.characters.isEmpty:
                ErrorView(error: error) {
                    await viewModel.loadNextPage()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            default:
                ZStack {
                    CharactersListView(characters: viewModel.characters, viewModel: viewModel)

                    if case .error(let error) = viewModel.state {
                        ErrorView(error: error) {
                            await viewModel.loadNextPage()
                        }
                    }
                }
            }
        }
        .task {
            await viewModel.loadNextPage()
        }
    }
}

extension ListScreen {
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
                    }

                    if viewModel.canLoadMore, !characters.isEmpty {
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

    struct LoaderView: View {
        var body: some View {
            ZStack {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

extension CharacterUI {
    var accessibilityLabel: String {
        "\(name), \(status)"
    }
}
