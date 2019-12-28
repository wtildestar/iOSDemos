//
//  Constants.swift
//  MiniСinema
//
//  Created by Алексей Пархоменко on 11/03/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let topDistanceToView: CGFloat = 20
    static let leftDistanceToView: CGFloat = 20
    static let rightDistanceToView: CGFloat = 20
    static let bottomDistanceToView: CGFloat = 20
    static let galleryMinimumInteritemSpacing: CGFloat = 20
    static let galleryItemWidth = (UIScreen.main.bounds.width - Constants.leftDistanceToView - Constants.rightDistanceToView - Constants.galleryMinimumInteritemSpacing) / 2
    static let galleryItemHeight = (Constants.galleryItemWidth / 9) * 16
}
