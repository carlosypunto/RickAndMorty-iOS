// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Observation
import RickAndMortyDomain
import SwiftUI

extension ListScreenViewModel {
    enum ViewState: Equatable {
        case success(characters: [CharacterUI])
        case loading
        case error(currentCharacters: [CharacterUI])
    }
}

@Observable
final class ListScreenViewModel {
    private(set) var viewState: ViewState = .loading
    private(set) var canLoadMore = false
    var presentedError: ScreenError?

    private let getCharactersPageUseCase: GetCharactersPageUseCase

    @ObservationIgnored private var lastPage = 0
    @ObservationIgnored private var loading = false
    @ObservationIgnored private var characters: [CharacterUI] = []
    @ObservationIgnored private var task: Task<(), Never>?

    init(getCharactersPageUseCase: GetCharactersPageUseCase) {
        self.getCharactersPageUseCase = getCharactersPageUseCase
    }

    @MainActor
    func loadNextPage() {
        guard task == nil else {
            return
        }

        task = Task {
            await loadNextPageAsync()
        }
    }

    private func loadNextPageAsync() async {
        guard !loading else { return }
        presentedError = nil
        loading = true
        defer {
            loading = false
            task = nil
        }

        let nextPage = lastPage + 1
        do {
            let page = try await getCharactersPageUseCase.execute(page: nextPage)
            canLoadMore = !page.isLast
            let newCharacters = page.elements.map(\.toUI)
            characters.append(contentsOf: newCharacters)
            viewState = .success(characters: characters)
            lastPage = nextPage
        } catch {
            presentedError = ScreenError.from(error)
            viewState = .error(currentCharacters: characters)
        }
    }

    private let preloadThreshold = 5
    func shouldPreload(for character: CharacterUI) -> Bool {
        guard !loading, canLoadMore else { return false }
        guard let index = characters.firstIndex(where: { $0.id == character.id }) else { return false }
        return index >= characters.count - preloadThreshold
    }
}
