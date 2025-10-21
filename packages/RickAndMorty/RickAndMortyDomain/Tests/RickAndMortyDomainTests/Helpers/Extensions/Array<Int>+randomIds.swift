// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

extension Array<Int> {
    static func randomIds() -> [Int] {
        let count = Int.random(in: 2...10)
        let idsSet = Array(repeating: 0, count: count)
            .reduce(into: Set<Int>()) { acc, _ in acc.insert(Int.random(in: 2..<50)) }
        return Array(idsSet)
    }
}
