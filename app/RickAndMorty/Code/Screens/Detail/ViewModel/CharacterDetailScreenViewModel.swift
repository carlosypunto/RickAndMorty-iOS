// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Observation
import RickAndMortyDomain
import SwiftUI

extension CharacterDetailScreenViewModel {
    enum ViewState: Equatable {
        case idle
    }
}

@Observable
final class CharacterDetailScreenViewModel {
    private(set) var state: ViewState = .idle

    let character: CharacterUI

    init(character: CharacterUI) {
        self.character = character
    }
}
