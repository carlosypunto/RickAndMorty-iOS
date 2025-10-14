// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import Testing
@testable import NetworkClient

struct DefaultRequestBuilderTests {
    let baseURL = URL(string: "https://rickandmortyapi.com/api")!

    @Test func test_request_without_path() {
        let builder = RequestBuilder(base: baseURL)
        #expect(builder.request.url == baseURL)
    }

    @Test func test_request_with_path() {
        let builder = RequestBuilder(base: baseURL)
        builder.setPath("test")
        let expectedURL = baseURL.appending(path: "test")
        #expect(builder.request.url == expectedURL)
    }

    @Test func test_setting_path_returns_same_builder() {
        let builder = RequestBuilder(base: baseURL)
        let returnedBuilder = builder.setPath("test")
        #expect(builder === returnedBuilder)
    }

    @Test func test_request_changing_the_path() {
        let builder = RequestBuilder(base: baseURL)

        builder.setPath("first")
        #expect(builder.request.url == baseURL.appending(path: "first"))

        builder.setPath("second")
        #expect(builder.request.url == baseURL.appending(path: "second"))
    }

    @Test func test_request_adding_one_queryitem() {
        let builder = RequestBuilder(base: baseURL)

        builder.addQueryItem(name: "first", value: "first_value")
        #expect(builder.request.url!.absoluteString.hasSuffix("?first=first_value"))
    }

    @Test func test_request_adding_one_queryitem_withoutValue() {
        let builder = RequestBuilder(base: baseURL)

        builder.addQueryItem(name: "first", value: nil)
        #expect(builder.request.url!.absoluteString.hasSuffix("?first"))
    }

    @Test func test_request_adding_several_queryitems() {
        let builder = RequestBuilder(base: baseURL)

        builder.addQueryItem(name: "first", value: "first_value")
        builder.addQueryItem(name: "second", value: "second_value")

        let requestUrlString = builder.request.url!.absoluteString
        let queryItemsParts = requestUrlString.split(separator: "?")[1]
            .split(separator: "&")
            .map(String.init)

        #expect(queryItemsParts.contains("first=first_value") && queryItemsParts.contains("second=second_value"))
    }

    @Test func test_request_adding_two_queryitem_withoutValue() {
        let builder = RequestBuilder(base: baseURL)

        builder.addQueryItem(name: "first", value: nil)
        builder.addQueryItem(name: "second", value: nil)
        let requestUrlString = builder.request.url!.absoluteString

        #expect(requestUrlString.hasSuffix("?first&second") || requestUrlString.hasSuffix("?second&first"))
    }
}
