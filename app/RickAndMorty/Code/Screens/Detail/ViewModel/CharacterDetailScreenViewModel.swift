// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Observation
import RickAndMortyDomain
import SwiftUI

extension CharacterDetailScreenViewModel {
    enum ViewState: Equatable {
        case idle
        case loading
        case success
        case error(ScreenError)
    }
}

@Observable
final class CharacterDetailScreenViewModel {
    private(set) var state: ViewState = .idle

    @ObservationIgnored private var loading = false
    @ObservationIgnored private(set) var episodes: [EpisodeUI] = []

    let character: CharacterUI

    private let getEpisodesByIdsUseCase: GetEpisodesByIdsUseCase

    init(character: CharacterUI, getEpisodesByIdsUseCase: GetEpisodesByIdsUseCase) {
        self.character = character
        self.getEpisodesByIdsUseCase = getEpisodesByIdsUseCase
    }

    func loadEpisodes() async {
        guard !loading else { return }
        loading = true
        defer { self.loading = false }

        state = .loading

        do {
            let episodes = try await self.getEpisodesByIdsUseCase.execute(ids: character.episodes)
            self.episodes += episodes.map(\.toUI)
            self.state = .success
        } catch {
            self.state = .error(ScreenError.from(error))
        }
    }
}
