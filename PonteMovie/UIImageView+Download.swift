//
//  UIImageView+Download.swift
//  PonteMovie
//
//  Created by Kovari Armand on 2017. 04. 04..
//  Copyright © 2017. Kovari Armand. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadImageWithURL(url: URL, callback: @escaping (UIImage) -> ()) -> URLSessionDownloadTask {
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: url, completionHandler: {
            [weak self] url, response, error in
            if error == nil && url != nil {
                if let data = NSData(contentsOf: url!) {
                    if let image = UIImage(data: data as Data) {
                        DispatchQueue.main.async(execute: {
                            if let strongSelf = self {
                                strongSelf.image = image
                                callback(image)
                            }
                        })
                    }
                }
            }
        })
        downloadTask.resume()
        return downloadTask
    }
}
