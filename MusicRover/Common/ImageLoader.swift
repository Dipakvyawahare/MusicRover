//
//  ImageLoader.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 26/01/20.
//  Copyright © 2020 MyOrganization. All rights reserved.
//

import UIKit
private  let imageCache = NSCache<NSString, UIImage>()

final class ImageLoader {
    static let shared = ImageLoader()
    private init() {}
    
    public func loadImage(urlString: String,
                          completionHandler: @escaping ((UIImage?, String) -> Void)) -> URLSessionDataTask? {
        var task: URLSessionDataTask?
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            DispatchQueue.main.async {
                completionHandler(cachedImage, urlString)
            }
        } else {
            task = URLSession.shared.dataTask(with: URL(string: urlString)!,
                                              completionHandler: { (data, _, error) -> Void in
                                                
                                                if error != nil {
                                                    completionHandler(nil, urlString)
                                                    return
                                                }
                                                guard let data = data else {
                                                    completionHandler(nil, urlString)
                                                    return
                                                }
                                                DispatchQueue.main.async(execute: { () -> Void in
                                                    if let downloadedImage = UIImage(data: data) {
                                                        imageCache.setObject(downloadedImage,
                                                                             forKey: NSString(string: urlString))
                                                        completionHandler(downloadedImage, urlString)
                                                    }
                                                })
                                                
            })
        }
        task?.resume()
        return task
    }
}
