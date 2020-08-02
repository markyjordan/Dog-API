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
            
            // confirm data received back as response is not nil
            guard let data = data else {
                return
            }
            print(data)
            
            // parse JSON with Codable protocol
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImage.self, from: data)
            print(imageData)
            
//            // parse JSON with JSONSerialization
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//                let url = json["message"] as! String
//                print(url)
//            } catch {
//                print(error)
//            }
        }
        task.resume()
    }


}

