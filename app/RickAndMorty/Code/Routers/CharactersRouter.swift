// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import SwiftUI
import Observation

enum CharactersRoute: Hashable {
    case toDetail(CharacterUI)
}

@Observable
final class CharactersRouter {
    var path = NavigationPath()
    func push(_ route: CharactersRoute) { path.append(route) }
    func popToRoot() { path = NavigationPath() }

    @ViewBuilder
    func makeDestination(route: CharactersRoute) -> some View {
        switch route {
        case .toDetail(let character):
            CharacterDetailScreenFactory.view(character: character)
        }
    }
}
