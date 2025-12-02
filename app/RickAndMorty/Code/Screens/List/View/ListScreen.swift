// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import SwiftUI

struct ListScreen: View {
    @State private var viewModel: ListScreenViewModel

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
                    CharactersListView()
                        .environment(viewModel)

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
    struct LoaderView: View {
        var body: some View {
            ZStack {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

#Preview {
    ListScreen(viewModel: .init(getCharactersPageUseCase: GetCharactersPageUseCaseStub()))
}
