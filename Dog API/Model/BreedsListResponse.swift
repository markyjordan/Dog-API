//
//  BreedsListResponse.swift
//  Dog API
//
//  Created by Marky Jordan on 8/15/20.
//  Copyright © 2020 Marky Jordan. All rights reserved.
//

import Foundation

struct BreedsListResponse: Codable {
    
    let status: String
    let message: [String: [String]]
}
