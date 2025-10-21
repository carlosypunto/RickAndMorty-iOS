// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import SwiftUI

struct CharacterDetailScreen: View {
    @State var viewModel: CharacterDetailScreenViewModel

    init(viewModel: CharacterDetailScreenViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }

    var body: some View {
        Text(viewModel.character.name)
    }
}

#Preview {
    CharacterDetailScreen(viewModel: .init(character: CharacterUIStubs.rickSanchez))
}
