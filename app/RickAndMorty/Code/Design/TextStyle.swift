// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import SwiftUI

enum TextStyle {
    case header
    case cellMain
    case cellHeadline
}

extension Text {
    func textStyle(_ style: TextStyle) -> Text {
        switch style {
        case .header: self.font(.title2).fontWeight(.bold)
        case .cellMain: self.font(.title3).fontWeight(.light)
        case .cellHeadline: self.font(.headline)
        }
    }
}
