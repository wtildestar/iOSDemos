//
//  DiagramViewController.swift
//  OTUS test
//
//  Created by wtildestar on 26/01/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class DiagramViewController: UIViewController {
    
    var images = [UIImage]()
    
    lazy var imageViews: [UIImageView] = {
        let views = [
            UIImageView(frame: .zero),
            UIImageView(frame: .zero),
            UIImageView(frame: .zero)
        ]
        
        views.forEach { $0.contentMode = .scaleAspectFit }
        return views
    }()
    
    var dragging: Bool = false
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    var scrollViewSize: CGRect = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addImageViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollViewSize = scrollView.frame
        scrollView.contentSize = CGSize(
            width: scrollViewSize.width * 3,
            height: scrollViewSize.height
        )
        
        scrollView.contentOffset = CGPoint(
            x: scrollViewSize.width,
            y: 0
        )
        
        layoutImages()
    }
    
    // заполняю массив картинками
    func addImageViews() {
        (0..<3).forEach { i in
            if let img = Services.diagramImageProvider.random() {
                images.append(img)
                imageViews[i].image = img
                scrollView.addSubview(imageViews[i])
            }
        }
    }
    
    func layoutImages() {
        imageViews.enumerated().forEach { (index, element) in
            element.image = images[index]
            
            element.frame = CGRect(
                x: scrollViewSize.width * CGFloat(index),
                y: 0,
                width: scrollViewSize.width,
                height: scrollViewSize.height
            )
        }
    }

}

extension DiagramViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        dragging = true
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        dragging = false
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard dragging else { return }
        
        let offsetX = scrollView.contentOffset.x
        
        if offsetX > scrollView.frame.size.width * 1.5 {
            guard let newImg = Services.diagramImageProvider.random() else { return }
            
            images.remove(at: 0)
            images.append(newImg)
            layoutImages()
            scrollView.contentOffset.x -= scrollViewSize.width
        }
        
        if offsetX < scrollView.frame.size.width * 0.5 {
            guard let newImg = Services.diagramImageProvider.random() else { return }
            
            images.removeLast()
            images.insert(newImg, at: 0)
            layoutImages()
            scrollView.contentOffset.x += scrollViewSize.width
        }
    }
}
