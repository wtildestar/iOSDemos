//
//  ViewController.swift
//  PlayingCard
//
//  Created by wtildestar on 23/01/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var deck = PlayingCardDeck()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1...10 {
            if let card = deck.draw() {
                print("\(card)")
            }
        }
    }


}

