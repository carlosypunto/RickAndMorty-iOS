// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import SwiftUI

struct ListScreen: View {
    @State var viewModel: ListScreenViewModel

    init(viewModel: ListScreenViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            switch viewModel.viewState {
                case .success(let characters):
                    CharactersListView(characters: characters, viewModel: viewModel)
                case .error(currentCharacters: let currentCharacters):
                    CharactersListView(characters: currentCharacters, viewModel: viewModel)
                case .loading:
                    LoaderView()
            }
        }
        .fullScreenCover(item: $viewModel.presentedError) { error in
            ErrorView(error: error) {
                viewModel.loadNextPage()
            }
        }
        .task {
            viewModel.loadNextPage()
        }
    }
}

extension ListScreen {
    struct LoaderView: View {
        var body: some View {
            VStack {
                ProgressView()
            }
        }
    }
}
