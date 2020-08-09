//
//  ViewController.swift
//  Dog API
//
//  Created by Marky Jordan on 7/30/20.
//  Copyright © 2020 Marky Jordan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    
    let breeds = [String]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the pickerView data source and delegate
        pickerView.dataSource = self
        pickerView.delegate = self
        
        // generate image request from the dog API
        DogAPI.requestRandomImage(completionHandler: handleRandomImageResponse(imageData:error:))
    }
    
    func handleRandomImageResponse(imageData: DogImage?, error: Error?) {
        // convert the message property of imageData into a URL in order to fetch the image data
        // create a constant that stores the message property of the image data
        guard let imageURL = URL(string: imageData?.message ?? "") else {
            return
        }
        // implement requestImageFile as a network request
        DogAPI.requestImageFile(url: imageURL, completionHandler: self.handleImageFileResponse(image:error:))
    }
    
    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    // UIPickerView Data Source methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
}

