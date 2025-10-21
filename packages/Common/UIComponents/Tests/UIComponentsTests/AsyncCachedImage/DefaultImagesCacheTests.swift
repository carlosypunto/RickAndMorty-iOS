// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import UIKit
import Testing
@testable import UIComponents

@Suite("DefaultImagesCache")
struct DefaultImagesCacheTests {

    @Test("returns nil for nil URL")
    func returnsNilForNilURL() async throws {
        let sut = DefaultImagesCache()
        let image = await sut.image(from: nil)
        #expect(image == nil)
    }
    
    @Test("stores and retrieves an image")
    func storesAndRetrievesImage() async throws {
        let sut = DefaultImagesCache()
        let original = makeImage(color: .red)
        await sut.addImage(original, from: testURL1, cost: nil)
        let retrieved = await sut.image(from: testURL1)
        try #require(retrieved != nil)
        #expect(pngDataEqual(original, retrieved!))
    }
    
    @Test("updates existing entry for same URL")
    func updatesExistingEntryForSameURL() async throws {
        let sut = DefaultImagesCache()
        let imageA = makeImage(color: .blue)
        let imageB = makeImage(color: .green)
        
        await sut.addImage(imageA, from: testURL1, cost: nil)
        let retrievedA = await sut.image(from: testURL1)
        try #require(retrievedA != nil)
        #expect(pngDataEqual(imageA, retrievedA!))
        
        await sut.addImage(imageB, from: testURL1, cost: nil)
        let retrievedB = await sut.image(from: testURL1)
        try #require(retrievedB != nil)
        #expect(pngDataEqual(imageB, retrievedB!))
        #expect(!pngDataEqual(imageA, retrievedB!))
    }
    
    @Test("separate keys do not collide")
    func separateKeysDoNotCollide() async throws {
        let sut = DefaultImagesCache()
        let image1 = makeImage(color: .yellow)
        let image2 = makeImage(color: .purple)
        
        await sut.addImage(image1, from: testURL1, cost: nil)
        await sut.addImage(image2, from: testURL2, cost: nil)

        let retrieved1 = await sut.image(from: testURL1)
        let retrieved2 = await sut.image(from: testURL2)

        try #require(retrieved1 != nil)
        try #require(retrieved2 != nil)
        
        #expect(pngDataEqual(image1, retrieved1!))
        #expect(pngDataEqual(image2, retrieved2!))
        #expect(!pngDataEqual(retrieved1!, retrieved2!))
    }
    
    @Test("insertion with cost still retrieves image")
    func insertionWithCostStillRetrievesImage() async throws {
        let sut = DefaultImagesCache()
        let image = makeImage(color: .cyan)
        await sut.addImage(image, from: testURL1, cost: 1024)
        let retrieved = await sut.image(from: testURL1)
        try #require(retrieved != nil)
        #expect(pngDataEqual(image, retrieved!))
    }
    
    @Test("basic concurrent access is safe")
    func basicConcurrentAccessIsSafe() async throws {
        let sut = DefaultImagesCache()
        let image = makeImage(color: .magenta)

        try await withThrowingTaskGroup(of: Void.self) { group in
            for i in 0..<50 {
                group.addTask {
                    let url = URL(string: "https://example.com/image-\(i).png")!
                    await sut.addImage(image, from: url, cost: nil)
                }
            }
            try await group.waitForAll()
        }

        for i in stride(from: 0, to: 50, by: 10) {
            let url = URL(string: "https://example.com/image-\(i).png")!
            let retrieved = await sut.image(from: url)
            try #require(retrieved != nil)
            #expect(pngDataEqual(image, retrieved!))
        }
    }

    // MARK: - Helpers

    func makeImage(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()!
    }

    var testURL1: URL {
        URL(string: "https://example.com/a.png")!
    }

    var testURL2: URL {
        URL(string: "https://example.com/b.png")!
    }

    func pngDataEqual(_ lhs: UIImage, _ rhs: UIImage) -> Bool {
        guard
            let lhsData = lhs.pngData(),
            let rhsData = rhs.pngData()
        else { return false }

        return lhsData == rhsData
    }
}
