// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import Testing
@testable import NetworkClient

struct DefaultNetworkClientTests {
    static let url = URL(string: "https://rickandmortyapi.com/api")!
    var sut: NetworkClientImpl!

    @Test mutating func test_successful_request() async throws {
        let expectedData = "test_request_success".data(using: .utf8)!
        let session = MockURLSession.withSuccessResponse(url: Self.url, data: expectedData)
        let requestBuilder = DummyURLRequestBuilder(url: Self.url)
        sut = NetworkClientImpl(session: session)

        let (data, response) = try await sut.request(with: requestBuilder)

        #expect(data == expectedData)
        #expect(response.statusCode == 200)
        #expect(session.lastRequest?.url == Self.url)
    }

    @Test mutating func test_request_success_bad_response() async {
        let expectedData = "test_request_success_bad_response".data(using: .utf8)!
        let session = MockURLSession.withNonHTTPResponse(url: Self.url, data: expectedData)
        sut = NetworkClientImpl(session: session)
        let requestBuilder = DummyURLRequestBuilder(url: Self.url)

        do {
            _ = try await sut.request(with: requestBuilder)
            Issue.record("An error was expected to be thrown for incorrect answer")
        } catch let error as NetworkClientError {
            #expect(error == .notHTTPResponse)
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
    }

    @Test mutating func test_request_session_error_propagation() async {
        let session = MockURLSession.withErrorResponse(error: NSError.testError)
        sut = NetworkClientImpl(session: session)
        let requestBuilder = DummyURLRequestBuilder(url: Self.url)

        do {
            _ = try await sut.request(with: requestBuilder)
            Issue.record("A session error was expected to be released.")
        } catch {
            #expect((error as NSError).code == NSError.testError.code)
        }
    }

    @Test mutating func test_request_internet_offline_error() async {
        let session = MockURLSession.withErrorResponse(error: NSError.internetOfflineError)
        sut = NetworkClientImpl(session: session)
        let requestBuilder = DummyURLRequestBuilder(url: Self.url)

        do {
            _ = try await sut.request(with: requestBuilder)
            Issue.record("An internetOffline error was expected")
        } catch let error as NetworkClientError {
            #expect(error == .internetOffline)
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
    }
}

private extension NSError {
    static let testError = NSError(domain: "TestError", code: 123, userInfo: nil)
    static let internetOfflineError = NSError(domain: "NSURLErrorDomain", code: NSURLErrorNotConnectedToInternet, userInfo: nil)
}

extension MockURLSession {
    /// Helper for create a MockURLSession that will return successful responses
    /// - Parameters:
    ///   - url: url of the response
    ///   - data: data of the response
    ///   - statusCode: statusCode of the response
    ///   - headerFields: dictuinary with optional header data of the response
    /// - Returns: `MockURLSession` an `URLSessionProtocol` fake implementation
    static func withSuccessResponse(
        url: URL,
        data: Data,
        statusCode: Int = 200,
        headerFields: [String: String]? = nil
    ) -> MockURLSession {
        let response = HTTPURLResponse(
            url: url,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: headerFields
        )!

        let mockSession = MockURLSession()
        mockSession.data = data
        mockSession.urlResponse = response
        return mockSession
    }

    /// Helper for create a MockURLSession that will return successful responses
    /// - Parameters:
    ///   - url: url of the response
    ///   - data: data of the response
    /// - Returns: `MockURLSession` an `URLSessionProtocol` fake implementation
    static func withNonHTTPResponse(
        url: URL,
        data: Data
    ) -> MockURLSession {
        let nonHTTPResponse = URLResponse(
            url: url,
            mimeType: "text/html",
            expectedContentLength: data.count,
            textEncodingName: nil
        )

        let mockSession = MockURLSession()
        mockSession.data = data
        mockSession.urlResponse = nonHTTPResponse
        return mockSession
    }

    /// Helper for create a MockURLSession that will return error responses
    /// - Parameters:
    ///   - error: data of the response
    /// - Returns: `MockURLSession` an `URLSessionProtocol` fake implementation
    static func withErrorResponse(error: Error) -> MockURLSession {
        let mockSession = MockURLSession()
        mockSession.error = error
        return mockSession
    }
}
