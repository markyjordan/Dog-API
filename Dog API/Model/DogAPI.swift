//
//  DogAPI.swift
//  Dog API
//
//  Created by Marky Jordan on 7/31/20.
//  Copyright © 2020 Marky Jordan. All rights reserved.
//

import Foundation

class DogAPI {
    
    enum Endpoint: String {
        case randomImageForAllDogsCollection = "https://dog.ceo/api/breeds/image/random"
        
        var url: URL {
            return URL(string: self.rawValue)!
        }
    }
}
