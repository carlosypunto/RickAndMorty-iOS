// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import SwiftUI

extension CharacterDetailScreen {
    struct CharacteristicsView: View {
        let character: CharacterUI

        var body: some View {
            VStack(spacing: Constant.spacing) {
                HStack(alignment: .firstTextBaseline) {
                    Text("charactersDetailScreen.locationLabel").textStyle(.label)
                    Text(character.location.name).textStyle(.regular)
                    Spacer(minLength: 0)
                }

                HStack(alignment: .firstTextBaseline) {
                    Text("charactersDetailScreen.originLabel").textStyle(.label)
                    Text(character.origin.name).textStyle(.regular)
                    Spacer(minLength: 0)
                }

                HStack(alignment: .top, spacing: Constant.spacing) {
                    VStack(alignment: .leading) {
                        HStack(alignment: .firstTextBaseline) {
                            Text("charactersDetailScreen.statusLabel").textStyle(.label)
                            Text(character.status.rawValue.capitalized).textStyle(.regular)
                            Spacer(minLength: 0)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)

                    VStack(alignment: .leading) {
                        HStack(alignment: .firstTextBaseline) {
                            Text("charactersDetailScreen.genderLabel").textStyle(.label)
                            Text(character.gender.rawValue.capitalized).textStyle(.regular)
                            Spacer(minLength: 0)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                }
            }
            .padding()
            .background(character.specieColor.opacity(0.2))
            .cornerRadius(Constant.cornerRadius)
        }
    }
}

private enum Constant {
    static let cornerRadius: CGFloat = 10
    static let spacing: CGFloat = 10
}
