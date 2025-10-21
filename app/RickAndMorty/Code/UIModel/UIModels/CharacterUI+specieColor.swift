// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import SwiftUI

public extension CharacterUI {
    var specieColor: Color {
        switch species.lowercased() {
        case "human": Color("humanBGColor")
        case "humanoid": Color("humanoidBGColor")
        case "alien": Color("alienBGColor")
        default: .clear
        }
    }
}
