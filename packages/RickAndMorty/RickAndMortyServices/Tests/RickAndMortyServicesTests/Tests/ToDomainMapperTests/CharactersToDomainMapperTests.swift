// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import Testing
import NetworkClient
@testable import RickAndMortyServices

struct CharactersToDomainMapperTests {
    @Test func test_characters_page_mapper() async {
        let dtoPage = DTO.Character.charactersPageStub
        let domainPage = dtoPage.toDomain
        #expect(domainPage.isLast == false)
        #expect(domainPage.elements.count == dtoPage.results.count)
    }

    @Test func test_characters_mapper() async {
        let dtosArray = DTO.Character.charactersArrayStub
        let domainsArray = dtosArray.map(\.toDomain)
        #expect(domainsArray.first!.episodes.count == dtosArray.first!.episode.count)
        #expect(domainsArray[1].episodes.count == dtosArray[1].episode.count)
    }

    @Test func test_character_mapper() async {
        let dto = DTO.Character.firstCharacterStub
        let domain = dto.toDomain
        #expect(domain.episodes.count == dto.episode.count)
    }
}
