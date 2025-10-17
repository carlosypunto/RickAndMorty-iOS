// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

enum ScreenError: Int, Identifiable {
    case unmanageable
    case offline
    case canRetry

    var id: Int {
        rawValue
    }
}
