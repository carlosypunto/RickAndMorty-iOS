// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

public struct Page<Element> {
    let isLast: Bool
    let elements: [Element]

    public init(isLast: Bool, elements: [Element]) {
        self.isLast = isLast
        self.elements = elements
    }
}
