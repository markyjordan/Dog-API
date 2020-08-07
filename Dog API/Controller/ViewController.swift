//
//  ViewController.swift
//  Dog API
//
//  Created by Marky Jordan on 7/30/20.
//  Copyright © 2020 Marky Jordan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // generate image request
        let randomImageEndpoint = DogAPI.Endpoint.randomImageForAllDogsCollection.url
        
        // create URLSessionDataTask
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
            
            // convert the message property into a URL in order to fetch the image data
            // create a constant that stores the message property of the image data
            guard let imageURL = URL(string: imageData.message) else {
                return
            }
            
            // implement requestImageFile as a network request
            DogAPI.requestImageFile(url: imageURL, completionHandler: self.handleImageFileResponse(image:error:))
        }
        task.resume()
    }
    
    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}

