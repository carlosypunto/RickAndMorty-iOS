// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Observation
import RickAndMortyDomain
import SwiftUI

extension ListScreenViewModel {
    enum ViewState: Equatable {
        case idle
        case loading
        case success
        case error(ScreenError)
    }
}

@Observable
final class ListScreenViewModel {
    private(set) var state: ViewState = .idle
    private(set) var canLoadMore = true

    @ObservationIgnored private var nextPage: Int = 1
    @ObservationIgnored private var loading = false
    @ObservationIgnored private(set) var characters: [CharacterUI] = []

    private let getCharactersPageUseCase: GetCharactersPageUseCase

    init(getCharactersPageUseCase: GetCharactersPageUseCase) {
        self.getCharactersPageUseCase = getCharactersPageUseCase
    }

    func loadNextPage() async {
        guard !loading, canLoadMore else { return }
        loading = true
        defer { self.loading = false }

        state = .loading

        do {
            let page = try await self.getCharactersPageUseCase.execute(page: self.nextPage)
            self.characters += page.elements.map(\.toUI)
            self.canLoadMore = !page.isLast
            self.nextPage += 1
            self.state = .success
        } catch {
            self.state = .error(ScreenError.from(error))
        }
    }
}
