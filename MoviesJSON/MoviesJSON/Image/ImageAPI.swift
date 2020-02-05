//
//  ImageAPI.swift
//  MoviesJSON
//
//  Created by wtildestar on 05/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit
import Combine

class ImageAPI {
    static let shared = ImageAPI()
    static let basePath = "https://image.tmdb.org/t/p/"
    
    enum Size: String {
        case small  = "w154"
        case medium = "w500"
        case large  = "w780"
        case original = "original"
        
        case cast   = "w185"
        
     func path(poster: String?) -> URL? {
        return (poster != nil && poster != "null")
            ? URL(string:  (basePath + rawValue))!.appendingPathComponent(poster!)
            : nil
        }
    }
}
