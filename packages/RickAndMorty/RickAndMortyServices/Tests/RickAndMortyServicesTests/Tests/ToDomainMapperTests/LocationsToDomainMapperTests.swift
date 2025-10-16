// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import Testing
import NetworkClient
@testable import RickAndMortyServices

struct LocationsToDomainMapperTests {
    @Test func test_locations_page_mapper() async {
        let dtoPage = DTO.Location.locationsPageStub
        let domainPage = dtoPage.toDomain
        #expect(domainPage.isLast == false)
        #expect(domainPage.elements.count == dtoPage.results.count)
    }

    @Test func test_locations_mapper() async {
        let dtosArray = DTO.Location.locationsArrayStub
        let domainsArray = dtosArray.map(\.toDomain)
        #expect(domainsArray.first!.residents.count == dtosArray.first!.residents.count)
        #expect(domainsArray[1].residents.count == dtosArray[1].residents.count)
    }

    @Test func test_location_mapper() async {
        let dto = DTO.Location.firstLocationStub
        let domain = dto.toDomain
        #expect(domain.residents.count == dto.residents.count)
    }
}
