// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import SwiftUI
import RickAndMortyDomain

private enum Constant {
    static let imageSide: CGFloat = 50
    static let cornerRadius: CGFloat = 5
    static let hSpacing: CGFloat = 15
}

extension ListScreen {
    struct CharacterCell: View {
        let character: CharacterUI

        var body: some View {
            VStack {
                HStack(spacing: Constant.hSpacing) {
                    image
                        .aspectRatio(contentMode: .fill)
                        .frame(width: Constant.imageSide, height: Constant.imageSide)
                        .cornerRadius(Constant.cornerRadius)

                    VStack(alignment: .leading) {
                        Text(character.name)
                            .textStyle(.cellMain)
                        Text(character.species)
                            .textStyle(.cellHeadline)
                    }
                }
            }
        }

        @ViewBuilder
        var image: some View {
            if let imageURL = URL(string: character.image) {
                AsyncImage(
                    url: imageURL,
                    content: { image in
                        image
                            .resizable()
                    },
                    placeholder: {
                        Image("placeholder")
                            .resizable()
                    }
                )
            } else {
                Image("placeholder")
                    .resizable()
            }
        }
    }
}

#Preview {
    NavigationView {
        List {
            ForEach(CharacterUIStubs.pageOneCharacters) { character in
                ListScreen.CharacterCell(character: character)
            }
        }
        .listStyle(.inset)
        .navigationTitle("Characters")
    }
}

#Preview {
    ListScreen(viewModel: .init(getCharactersPageUseCase: GetCharactersPageUseCaseStub()))
}
