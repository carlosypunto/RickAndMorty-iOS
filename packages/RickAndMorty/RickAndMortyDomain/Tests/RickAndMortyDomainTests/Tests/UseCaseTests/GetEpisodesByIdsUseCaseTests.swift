// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import Testing
@testable import RickAndMortyDomain

struct GetEpisodesByIdsUseCase {
    @Test func test_getEpisodesByIds_parameters() async {
        let repository = RickAndMortyRepositorySpy()
        let ids = [Int].randomIds().sorted()
        let sut = GetEpisodesByIdsUseCaseImpl(repository: repository)
        _ = try! await sut.execute(ids: ids)
        #expect(repository.requestedIds == ids)
    }
}
