//
//  SectionData.swift
//  dropDownSpotsApp
//
//  Created by wtildestar on 31/01/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

struct SectionData {
    var open: Bool
    var data: [CellData]
}

struct CellData {
    var title: String
    var featureImage: UIImage
}
