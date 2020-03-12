//
//  ViewController.swift
//  PhotoFilter
//
//  Created by wtildestar on 11/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var applyFilterButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nav = segue.destination as? UINavigationController,
            let photoVC = nav.viewControllers.first as? PhotoCollectionVC
            else {
                fatalError("Segue destination is not found")
        }
        photoVC.selectedPhoto.subscribe(onNext: { [weak self] photo in
            DispatchQueue.main.async {
                self?.updateUI(with: photo)
            }
        }).disposed(by: disposeBag)
    }
    
    @IBAction func applyFilterButtonPressed() {
        guard let sourceImage = self.photoImageView.image else { return }
        
        FiltersService().applyFilter(to: sourceImage) { filteredImage in
            DispatchQueue.main.async {
                self.photoImageView.image = filteredImage
            }
        }
    }
    
    private func updateUI(with image: UIImage) {
        self.photoImageView.image = image
        self.applyFilterButton.isHidden = false
    }
}

