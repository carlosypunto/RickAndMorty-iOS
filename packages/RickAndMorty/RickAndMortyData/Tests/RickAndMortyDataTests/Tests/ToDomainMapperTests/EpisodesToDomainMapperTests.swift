// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import Testing
import NetworkClient
@testable import RickAndMortyData

struct EpisodesToDomainMapperTests {
    @Test func test_episodes_page_mapper() async {
        let dtoPage = DTO.Episode.episodesPageStub
        let domainPage = dtoPage.toDomain
        #expect(domainPage.isLast == false)
        #expect(domainPage.elements.count == dtoPage.results.count)
    }

    @Test func test_episodes_mapper() async {
        let dtosArray = DTO.Episode.episodesArrayStub
        let domainsArray = dtosArray.map(\.toDomain)
        #expect(domainsArray.first!.characters.count == dtosArray.first!.characters.count)
        #expect(domainsArray[1].characters.count == dtosArray[1].characters.count)
    }

    @Test func test_episode_mapper() async {
        let dto = DTO.Episode.firstEpisodeStub
        let domain = dto.toDomain
        #expect(domain.characters.count == dto.characters.count)
    }
}
