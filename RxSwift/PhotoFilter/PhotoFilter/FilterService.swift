//
//  FilterService.swift
//  PhotoFilter
//
//  Created by wtildestar on 12/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit
import CoreImage
import RxSwift

class FiltersService {
    private var context: CIContext
    
    init() {
        self.context = CIContext()
    }
    
    func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
        return Observable<UIImage>.create { observer in
            self.applyFilter(to: inputImage) { filteredImage in
                observer.onNext(filteredImage)
            }
            
            return Disposables.create()
        }
    }
    
    private func applyFilter(to inputImage: UIImage, completion: @escaping ((UIImage) -> Void)) {

        let filter = CIFilter(name: "CIGlassLozenge")!
        filter.setValue(1.04, forKey: kCIInputRefractionKey)
        filter.setValue(40.0, forKey: kCIInputRadiusKey)
        filter.setValue(CIVector(x: 100, y: 120), forKey: "inputPoint0")
        filter.setValue(CIVector(x: 190, y: 100), forKey: "inputPoint1")        
        
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
