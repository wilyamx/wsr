//
//  WSRImageCache.swift
//  WSR
//
//  Created by William S. Rena on 9/16/24.
//

import UIKit

/**
    https://xavier7t.com/image-caching-in-swiftui
 */
public class WSRImageCache {
    public static let shared = WSRImageCache()

    private let cache = NSCache<NSString, UIImage>()

    private init() {}

    public func set(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }

    public func get(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    public func remove(forKey key: String) {
        return cache.removeObject(forKey: key as NSString)
    }
}
