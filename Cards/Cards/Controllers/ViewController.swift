//
//  ViewController.swift
//  Cards
//
//  Created by wtildestar on 09/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

// MARK: - Dependencies

struct Constants {
    static var behaviorResistance: CGFloat = 0
    static var behaviorElasticity: CGFloat = 1.0
    static var behaviorPushMagnitudeMinimum: CGFloat = 0.5
    static var behaviorPushMagnitudeRandomFactor: CGFloat = 1.0
}

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var seconds = 60
    var timer = Timer()
    let creationDate = Date()
    var cards = [PlayingCard]()
    
    var cardsCount = 0 {
        didSet {
            if self.cardsCount == 12 {
                timer.invalidate()
                presenting()
             }
        }
    }
    
    lazy var animator = UIDynamicAnimator(referenceView: view)
    // экземпляр анимации поведения карты
    lazy var cardBehavior = CardBehavior(in: animator)
    private var deck = PlayingCardDeck()
    
    // MARK: - Outlets
    
    @IBOutlet var cardViews: [PlayingCardView]!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: - Methods
    
    private func presenting() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let yourScoreVC = storyBoard.instantiateViewController(withIdentifier: "YourTime") as! YourTimeViewController
        yourScoreVC.time = self.timeLabel.text!
        self.present(yourScoreVC, animated:true, completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 1...((cardViews.count + 1)/2) {
            let card = deck.draw()!
            cards += [card, card]
        }
        for cardView in cardViews {
            cardView.isFaceUp = false
            let card = cards.remove(at: cards.count.arc4Random)
            cardView.rank = card.rank.order
            cardView.suit = card.suit.rawValue
            cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipCard(_:))))
            // добавление поведения анимации
            cardBehavior.addItem(cardView)
        }
        runTimer()
    }
    
    func runTimer() {
         timer = Timer.scheduledTimer(timeInterval: 1,
                                      target: self,
                                      selector: (#selector(ViewController.updateTimer)),
                                      userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
             timer.invalidate()
            presentingLoseVC()
        } else {
             seconds -= 1
            timeLabel.text = "\(seconds)"
        }
    }
    
    private func presentingLoseVC() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let loseVC = storyBoard.instantiateViewController(withIdentifier: "LoseVC") as! LoseViewController
        self.present(loseVC, animated:true, completion:nil)
    }
    
    // карты лицевой вверх
    private var faceUpCardViews: [PlayingCardView] {
        return cardViews.filter { $0.isFaceUp && !$0.isHidden && $0.transform != CGAffineTransform.identity.scaledBy(x: 3.0, y: 3.0) && $0.alpha == 1 }
    }
    
    private var faceUpCardViewsMatch: Bool {
        return faceUpCardViews.count == 2 &&
            faceUpCardViews[0].rank == faceUpCardViews[1].rank &&
            faceUpCardViews[0].suit == faceUpCardViews[1].suit
    }
    
    var lastChosenCardView: PlayingCardView?
    
    @objc func flipCard(_ recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            // ограничение анимации по нажатию двух карт лицевой вверх
            if let chosenCardView = recognizer.view as? PlayingCardView, faceUpCardViews.count < 2 {
                lastChosenCardView = chosenCardView
                cardBehavior.removeItem(chosenCardView)
                UIView.transition(
                    with: chosenCardView,
                    duration: 0.5,
                    options: [.transitionFlipFromLeft],
                    animations: {
                        chosenCardView.isFaceUp = !chosenCardView.isFaceUp
                },
                    completion: { finished in
                        let cardsToAnimate = self.faceUpCardViews
                        if self.faceUpCardViewsMatch {
                            UIView.animate(
                                withDuration: 0.2,
                                delay: 0,
                                options: [],
                                animations: {
                                    cardsToAnimate.forEach {
                                        $0.transform = CGAffineTransform.identity.scaledBy(x: 2.0, y: 2.0)
                                    }
                            })
                            { (position) in
                                UIView.animate(
                                    withDuration: 0.4,
                                    delay: 0,
                                    options: [],
                                    animations: {
                                        cardsToAnimate.forEach {
                                            $0.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
                                            $0.alpha = 0
                                        }
                                })
                            }
                            self.cardsCount += 2
                            print(self.cardsCount)
                            
                        } else if cardsToAnimate.count == 2 {
                            if chosenCardView == self.lastChosenCardView {
                                cardsToAnimate.forEach { cardView in
                                    UIView.transition(
                                        with: cardView,
                                        duration: 0.5,
                                        options: [.transitionFlipFromLeft],
                                        animations: {
                                            cardView.isFaceUp = false
                                    },
                                        completion: { finished in
                                            self.cardBehavior.addItem(cardView)
                                        }
                                    )
                                }
                            }
                        } else {
                            if !chosenCardView.isFaceUp {
                                self.cardBehavior.addItem(chosenCardView)
                            }
                        }
                    }
                )
            }
        default:
            break
        }
    }
}

