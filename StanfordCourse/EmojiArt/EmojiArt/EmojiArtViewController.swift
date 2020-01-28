//
//  EmojiArtViewController.swift
//  EmojiArt
//
//  Created by wtildestar on 28/01/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class EmojiArtViewController: UIViewController, UIDropInteractionDelegate {

    
    @IBOutlet weak var dropZone: UIView! {
        didSet {
            dropZone.addInteraction(UIDropInteraction(delegate: self))
        }
    }
    
    // объекты для перетаскивания
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSURL.self) && session.canLoadObjects(ofClass: UIImage.self)
    }
    
    // для перетаскивания использую .copy operation
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        session.loadObjects(ofClass: NSURL.self) { nsurls  in
            <#code#>
        }
        session.loadObjects(ofClass: UIImage.self) { images in
            <#code#>
        }
    }
    
    @IBOutlet weak var emojiArtView: EmojiArtView!
    
}
