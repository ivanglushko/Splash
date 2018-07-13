//
//  ImageDownloader.swift
//  Splash
//
//  Created by Ivan Glushko on 05/07/2018.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import UIKit

class ImageDownloader {
    
    private func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: String, completion: @escaping (NSData) -> () ) {
        guard let url = URL(string: url) else { return }
        getDataFromUrl(url: url) { (data, response, error) in
            guard let data = data, error == nil else { return }
            if let downloadedImage = UIImage(data: data) {
                let data = UIImagePNGRepresentation(downloadedImage)! as NSData
                print("Image has been downloaded")
                completion(data)
            }
            
        }
    }
}
