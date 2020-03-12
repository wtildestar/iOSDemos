//
//  FilterService.swift
//  PhotoFilter
//
//  Created by wtildestar on 12/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit
import CoreImage

class FiltersService {
    private var context: CIContext
    
    init() {
        self.context = CIContext()
    }
    
    func applyFilter(to inputImage: UIImage, completion: @escaping ((UIImage) -> Void)) {
        
        let filter = CIFilter(name: "CICMYKHalftone")!
        filter.setValue(5.0, forKey: kCIInputWidthKey)
        
        if let sourceImage = CIImage(image: inputImage) {
            filter.setValue(sourceImage, forKey: kCIInputImageKey)
            
            if let cgimg = self.context.createCGImage(
                filter.outputImage!, from: filter.outputImage!.extent) {
                let processedImage = UIImage(cgImage: cgimg,
                                             scale: inputImage.scale,
                                             orientation: inputImage.imageOrientation)
                completion(processedImage)
            }
        }
    }
}
