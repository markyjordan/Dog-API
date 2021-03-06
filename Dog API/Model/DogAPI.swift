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
    
    enum Endpoint {
        case randomImageForAllDogsCollection
        case randomImageForBreed(String)
        case listAllBreeds
        
        // create computed property to generate a URL from an enum case's raw value
        var url: URL {
            return URL(string: self.stringValue)!
        }
        
        // create computed property to build urls for a specific dog breed
        var stringValue: String {
            switch self {
            case .randomImageForAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images"
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            }
        }
    }
    // the async completionHandler passes back information to the caller (i.e. view controller)
    class func requestRandomImage (breed: String, completionHandler: @escaping (DogImage?, Error?) -> Void) {
        // initialize a constant with the URL endpoint
        let randomImageEndpoint = DogAPI.Endpoint.randomImageForBreed(breed).url

        // create URLSessionDataTask to generate a network request with the endpoint
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, response, error) in
            
            // confirm JSON data received back as response is not nil
            guard let data = data else {
                // JSON parsing was not successful; no data is passed back to view controller
                completionHandler(nil, error)
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
            
            do {
                // parse JSON with Codable protocol
                // initialize tho JSON decoder
                let jsonDecoder = JSONDecoder()
                
                // add the decoded JSON to the model object and create a constant that stores its location
                let imageData = try jsonDecoder.decode(DogImage.self, from: data)
                print(imageData)
                // JSON parsing is successful; pass image data (as DogImage struct) to view controller with completionHandler
                completionHandler(imageData, nil)
            } catch {
                print(error)
            }
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
    
    class func requestBreedsList (completionHandler: @escaping ([String], Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoint.listAllBreeds.url, completionHandler: { (data, response, error) in
            guard let data = data else {
                completionHandler([], error)
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let breedsList = try jsonDecoder.decode(BreedsListResponse.self, from: data)
                print(breedsList)
                let breeds = breedsList.message.keys.map({$0})
                print(breeds)
                completionHandler(breeds, nil)
            } catch {
                print(error)
            }
        })
        task.resume()
    }
}
