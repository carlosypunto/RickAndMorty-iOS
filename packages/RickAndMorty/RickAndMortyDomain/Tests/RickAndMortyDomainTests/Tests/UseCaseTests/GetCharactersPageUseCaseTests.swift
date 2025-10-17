// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import Testing
@testable import RickAndMortyDomain

struct GetCharactersPageUseCaseTests {
    @Test func test_getCharacters_firstPage_parameters() async {
        let repository = RickAndMortyRepositorySpy()
        let page = Int.random(in: 2 ..< 50)
        let sut = GetCharactersPageUseCase(repository: repository)
        _ = try! await sut.execute(page: page)
        #expect(repository.requestedPage == page)
    }
}
