// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import SwiftUI

/// A SwiftUI view that asynchronously loads an image from a remote URL
/// and caches it using an image cache provided via the `imagesCache` environment key.
///
/// The view renders a placeholder while loading, shows the provided `content`
/// when the image has been successfully fetched (either from cache or network),
/// and renders the placeholder again if loading fails.
///
/// Usage example:
/// ```swift
/// AsyncCachedImage(url: imageURL) { image in
///     image
///         .resizable()
///         .scaledToFill()
/// } placeholder: {
///     ProgressView()
/// }
/// ```
///
/// - Note: This view relies on an `imagesCache` environment value capable of
///   retrieving and storing `UIImage` instances. If none is supplied, the default
///   cache provided by `ImagesCacheKey.defaultValue` will be used.
public struct AsyncCachedImage<Content: View, Placeholder: View>: View {
    let url: URL
    @ViewBuilder var content: (Image) -> Content
    @ViewBuilder var placeholder: () -> Placeholder

    @Environment(\.imagesCache) private var cache
    @State private var phase: Phase = .empty

    /// Creates an async cached image view.
    ///
    /// - Parameters:
    ///   - url: The remote image URL to load.
    ///   - content: A builder that receives the loaded `Image` and returns the content to display.
    ///   - placeholder: A builder that returns a placeholder view shown while loading or on failure.
    public init(
        url: URL,
        @ViewBuilder content: @escaping (Image) -> Content,
        @ViewBuilder placeholder: @escaping () -> Placeholder
    ) {
        self.url = url
        self.content = content
        self.placeholder = placeholder
    }

    enum Phase {
        case empty
        case success(Image)
        case failure(Error)
    }

    /// The content of the view. It switches between `placeholder` and `content`
    /// depending on the current `phase`, and triggers loading when needed.
    public var body: some View {
        ZStack {
            switch phase {
            case .success(let image):
                content(image)
            case .failure:
                placeholder()
            case .empty:
                placeholder()
                    .task(id: url) {
                        await load()
                    }
            }
        }
    }

    /// Loads the image either from cache or from the network and updates `phase` accordingly.
    ///
    /// If the cache contains the image for `url`, it is used immediately. Otherwise, the image
    /// is fetched from the network, validated (status code and MIME type), converted to `UIImage`,
    /// stored in the cache, and then published as a SwiftUI `Image`.
    @MainActor
    private func load() async {
        if let uiImage = await cache.image(from: url) {
            phase = .success(Image(uiImage: uiImage))
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard
                let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode),
                let mime = response.mimeType, mime.hasPrefix("image"),
                let uiImage = UIImage(data: data)
            else {
                throw URLError(.badServerResponse)
            }

            await cache.addImage(uiImage, from: url, cost: uiImage.memoryCost)

            phase = .success(Image(uiImage: uiImage))
        } catch {
            phase = .failure(error)
        }
    }
}

extension AsyncCachedImage where Placeholder == ProgressView<EmptyView, EmptyView> {
    /// Convenience initializer that uses a default `ProgressView` as the placeholder.
    ///
    /// - Parameters:
    ///   - url: The remote image URL to load.
    ///   - content: A builder that receives the loaded `Image` and returns the content to display.
    init(
        url: URL,
        @ViewBuilder content: @escaping (Image) -> Content
    ) {
        self.url = url
        self.content = content
        self.placeholder = { ProgressView() }
    }
}

// MARK: - Helpers

private extension UIImage {
    var memoryCost: Int {
        guard let cg = self.cgImage else { return 0 }
        let bytesPerPixel = 4
        return cg.width * cg.height * bytesPerPixel
    }
}
