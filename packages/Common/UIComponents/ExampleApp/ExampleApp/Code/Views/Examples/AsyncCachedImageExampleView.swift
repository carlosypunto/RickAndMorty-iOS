// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import SwiftUI
import UIComponents

struct AsyncCachedImageExampleView: View {
    let url = URL(string: "https://picsum.photos/400")!

    var body: some View {
        AsyncCachedImage(url: url) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: Constant.imageSide, height: Constant.imageSide)
                .clipped()
                .cornerRadius(Constant.cornerRadius)
        } placeholder: {
            ZStack {
                Constant.placeholderBGColor
                ProgressView()
                    .controlSize(.small)
            }
            .frame(width: Constant.imageSide, height: Constant.imageSide)
            .cornerRadius(Constant.cornerRadius)
        }
        .navigationTitle("AsyncCachedImage")
    }
}

private enum Constant {
    static let imageSide: CGFloat = 120
    static let cornerRadius: CGFloat = 12
    static let placeholderBGColor: Color = Color.gray.opacity(0.15)
}

actor Example100MBCache: ImagesCache {
    static let shared = Example100MBCache()

    private let cache: NSCache<NSURL, UIImage> = {
        let cache = NSCache<NSURL, UIImage>()
        cache.totalCostLimit = 100 * 1024 * 1024
        return cache
    }()

    func addImage(_ image: UIImage, from url: URL, cost: Int? = nil) {
        if let cost { cache.setObject(image, forKey: url as NSURL, cost: cost) }
        else { cache.setObject(image, forKey: url as NSURL) }
    }

    func image(from url: URL?) -> UIImage? {
        guard let url else { return nil }
        return cache.object(forKey: url as NSURL)
    }
}

struct AsyncCachedImageWithCustomExample100MBCacheView: View {
    var body: some View {
        // You can also add a wrapper type implementing ImagesCache if desired.
        let custom = Example100MBCache()
        return ContentView()
            .environment(\.imagesCache, custom)
    }
}

#Preview("With Default Images Cache") {
    AsyncCachedImageExampleView()
}

#Preview("With 100MB Images Cache") {
    AsyncCachedImageWithCustomExample100MBCacheView()
}
