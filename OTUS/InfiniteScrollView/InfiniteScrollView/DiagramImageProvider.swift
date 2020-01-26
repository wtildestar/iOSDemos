//
//  DiagramImageProvider.swift
//  OTUS test
//
//  Created by wtildestar on 26/01/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

final class DiagramImageProvider {
    
    func random() -> UIImage? {
        let index = Int.random(in: 1..<11)
        return UIImage(named: "diagram_\(index)")
    }
    
}
