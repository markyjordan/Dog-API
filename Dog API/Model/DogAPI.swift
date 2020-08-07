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
        
        // create computed property to generate a URL from an enum case's raw value
        var url: URL {
            return URL(string: self.rawValue)!
        }
    }
    
    class func requestRandomImage (completionHandler: @escaping (UIImage?, Error?) -> Void) {
        // initialize a constant with the URL endpoint
        let randomImageEndpoint = DogAPI.Endpoint.randomImageForAllDogsCollection.url

        // create URLSessionDataTask to generate a network request with the endpoint
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, response, error) in
            
            // confirm JSON data received back as response is not nil
            guard let data = data else {
                return
            }
            print(data)
            
        //            // parse JSON with JSONSerialization
        //            do {
        //                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        //                let url = json["message"] as! String
        //                print(url)
        //            } catch {
        //                print(error)
        //            }
            
            // parse JSON with Codable protocol
            // initialize tho JSON decoder
            let decoder = JSONDecoder()
            
            // add the decoded JSON to the model object and create a constant that stores its location
            let imageData = try! decoder.decode(DogImage.self, from: data)
            print(imageData)
        }
        task.resume()
    }
    
    class func requestImageFile (url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let downloadedImage = UIImage(data: data)
            completionHandler(downloadedImage, nil)
        })
        task.resume()
    }
}
