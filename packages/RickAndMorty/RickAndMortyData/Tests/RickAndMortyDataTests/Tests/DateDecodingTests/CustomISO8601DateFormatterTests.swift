// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import Testing
@testable import RickAndMortyData

struct CustomISO8601DateFormatterTests {

    @Test func test_customWithISO8601Formatter_dateDecoding_threeDigits() async throws {
        let dateString = "2017-11-04T18:48:46.250Z"
        let date = Formatter.customISO8601DateFormatter.date(from: dateString)!
        #expect(date.timeIntervalSince1970 == 1509821326.25)
    }

    @Test func test_customWithISO8601Formatter_dateDecoding_sixDigits() async throws {
        let dateString = "2017-11-04T18:48:46.956087Z"
        let date = Formatter.customISO8601DateFormatter.date(from: dateString)!
        #expect(date.timeIntervalSince1970 == 1509821326.956)
    }
}
