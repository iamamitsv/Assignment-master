//
//  ImageManager.swift
//  Assignment
//
//  Created by Amit Srivastava on 24/06/22.
//  Copyright © 2022 Amit Srivastava. All rights reserved.
//

import UIKit

protocol ImageManaging: class {
    func downloadImageFromURL(_ urlString: String, completion: ((_ success: Bool, _ image: UIImage?) -> Void)?)
}

class ImageManager: NSObject {
    var imageCache = [String: UIImage]()
    private let lazyLoadMaxCacheImageSize = 20
    func cacheImage(_ image: UIImage, forURL url: String) {
        if imageCache.count > lazyLoadMaxCacheImageSize { // free old images first.
            imageCache.remove(at: imageCache.startIndex)
        }
        imageCache[url] = image
    }

    func cachedImageForURL(_ url: String) -> UIImage? { return imageCache[url] }
    func clearCache() { imageCache.removeAll() }

    func downloadImageFromURL(_ urlString: String, completion: ((_ success: Bool, _ image: UIImage?) -> Void)?) {
        // do we have this cached?
        if let cachedImage = cachedImageForURL(urlString) {
            DispatchQueue.main.async(execute: {completion?(true, cachedImage) })
        } else if let url = URL(string: urlString) { // download from URL asynchronously
            let session = URLSession.shared
            let downloadTask = session.downloadTask(with: url, completionHandler: { (retrievedURL, _, error) -> Void in
                var found = false
                if error != nil { print("Error downloading image \(url.absoluteString): \(error!.localizedDescription)") } else if retrievedURL != nil {
                    if let data = try? Data(contentsOf: retrievedURL!) {
                        if let image = UIImage(data: data) {
                            found = true
                            self.cacheImage(image, forURL: url.absoluteString)
                            DispatchQueue.main.async(execute: { completion?(true, image) })
                        }
                    }
                }
                if !found { DispatchQueue.main.async(execute: { completion?(false, nil) }); }
            })
            downloadTask.resume()
        } else { completion?(false, nil) }
    }

}
