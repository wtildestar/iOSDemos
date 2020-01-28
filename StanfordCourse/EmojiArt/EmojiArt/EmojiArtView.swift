//
//  EmojiArtView.swift
//  EmojiArt
//
//  Created by wtildestar on 28/01/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class EmojiArtView: UIView {
    
    var backgroundImage: UIImage? { didSet { setNeedsDisplay() } }
    
    override func draw(_ rect: CGRect) {
        backgroundImage?.draw(in: bounds)
    }

}
