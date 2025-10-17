// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import SwiftUI
import RickAndMortyDomain

private enum Constant {
    static let imageSide: CGFloat = 50
    static let cornerRadius: CGFloat = 5
    static let hSpacing: CGFloat = 15
}

struct CharacterCell: View {
    let character: CharacterUI

    var body: some View {
        VStack {
            HStack(spacing: Constant.hSpacing) {
                AsyncImage(
                    url: URL(string: character.image)!,
                    content: { image in
                        image
                            .resizable()
                    },
                    placeholder: {
                        Image("placeholder")
                            .resizable()
                    }
                )
                .aspectRatio(contentMode: .fill)
                .frame(width: Constant.imageSide, height: Constant.imageSide)
                .cornerRadius(Constant.cornerRadius)

                VStack(alignment: .leading) {
                    Text(character.name)
                        .font(.title3)
                        .fontWeight(.light)
                    Text(character.species)
                        .font(.headline)
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        List {
            ForEach(CharacterUIStubs.pageOneCharacters) { character in
                CharacterCell(character: character)
            }
        }
        .listStyle(.inset)
        .navigationTitle("Characters")
    }
}
