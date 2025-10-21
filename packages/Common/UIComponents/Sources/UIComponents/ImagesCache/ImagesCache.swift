import SwiftUI

/// A concurrency-safe image cache abstraction.
///
/// Conforming types must be `actor`s to ensure thread-safe access from Swift Concurrency.
/// This protocol is intentionally minimal to allow different backing stores (e.g., `NSCache`,
/// disk-backed caches, or custom solutions).
///
/// - Important: `AsyncCachedImage` will compute and pass an estimated memory `cost` (in bytes)
///   for each stored image. Custom cache implementations may use this value to inform eviction
///   strategies or memory budgeting.
///
/// - Note: When backed by `NSCache`, you can set `totalCostLimit` (bytes) to bound total memory.
public protocol ImagesCache: Actor {
    /// Store an image for a given URL.
    /// - Parameters:
    ///   - image: The image to cache.
    ///   - url: The canonical URL used as the cache key.
    ///   - cost: Optional estimated memory footprint in bytes. Provided by `AsyncCachedImage`.
    ///           Backends like `NSCache` can use this to influence eviction.
    func addImage(_ image: UIImage, from url: URL, cost: Int?)
    /// Retrieve a cached image for the given URL.
    /// - Parameter url: The URL used as the cache key. May be `nil` (returns `nil`).
    /// - Returns: The cached image if present, otherwise `nil`.
    func image(from url: URL?) -> UIImage?
}

/// Default `ImagesCache` implementation backed by `NSCache`.
///
/// - Uses an `NSCache<NSURL, UIImage>` for in-memory caching.
/// - `countLimit` defaults to 500 entries. Adjust as needed for your app.
/// - You can optionally set `totalCostLimit` (in bytes) to cap overall memory usage.
///
/// This cache honors the `cost` parameter passed to `addImage(…cost:)`, which allows
/// producers like `AsyncCachedImage` to influence eviction behavior.
actor DefaultImagesCache: ImagesCache {
    static let shared = DefaultImagesCache()

    private let cache: NSCache<NSURL, UIImage> = {
        let cache = NSCache<NSURL, UIImage>()
        cache.countLimit = 500
        // Optionally set a total cost limit (in bytes). For example, cap at ~100 MB:
        // cache.totalCostLimit = 100 * 1024 * 1024
        // Tune this value to your app's memory budget.
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

/// Environment key for injecting an `ImagesCache`.
///
/// Use `.environment(\.imagesCache, yourCache)` to override the default cache in view hierarchies.
public struct ImagesCacheKey: EnvironmentKey {
    public static let defaultValue: ImagesCache = DefaultImagesCache.shared
}

/// SwiftUI environment value for accessing or overriding the shared `ImagesCache`.
extension EnvironmentValues {
    public var imagesCache: ImagesCache {
        get { self[ImagesCacheKey.self] }
        set { self[ImagesCacheKey.self] = newValue }
    }
}
