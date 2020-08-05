//
//  DogAPI.swift
//  Dog API
//
//  Created by Marky Jordan on 7/31/20.
//  Copyright © 2020 Marky Jordan. All rights reserved.
//

import Foundation
import UIKit

class DogAPI {
    
    enum Endpoint: String {
        case randomImageForAllDogsCollection = "https://dog.ceo/api/breeds/image/random"
        
        var url: URL {
            return URL(string: self.rawValue)!
        }
    }
    
    class func requestImageFile (url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data else {
                return
            }
            let downloadedImage = UIImage(data: data)
        })
        task.resume()
    }
}
