//
//  ViewController.swift
//  Cards
//
//  Created by wtildestar on 09/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

struct Constants {
    static var flipCardAnimationDuration: TimeInterval = 0.6
    static var matchCardAnimationDuration: TimeInterval = 0.6
    static var matchCardAnimationScaleUp: CGFloat = 3.0
    static var matchCardAnimationScaleDown: CGFloat = 0.1
    static var behaviorResistance: CGFloat = 0
    static var behaviorElasticity: CGFloat = 1.0
    static var behaviorPushMagnitudeMinimum: CGFloat = 0.5
    static var behaviorPushMagnitudeRandomFactor: CGFloat = 1.0
    static var cardsPerMainViewWidth: CGFloat = 5
}


class ViewController: UIViewController {
    
    let creationDate = Date()
    var cards = [PlayingCard]()
    
    @IBOutlet weak var timeLabel: UILabel!
    
    var seconds = 60
    var timer = Timer()
    var isTimerRunning = false
    
    private var deck = PlayingCardDeck()
    
    @IBOutlet var cardViews: [PlayingCardView]! {
        didSet {
            if self.cardViews.count == 0 {
                self.dismiss(animated: true, completion: nil)
                print(cardViews.count)
            }
        }
    }
    
    lazy var animator = UIDynamicAnimator(referenceView: view)
    
    // экземпляр анимации поведения карты
    lazy var cardBehavior = CardBehavior(in: animator)
    
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
        if self.cardViews.count == 0 {
           self.dismiss(animated: true, completion: nil)
       }
        runTimer()
    }
    
    
    func runTimer() {
         timer = Timer.scheduledTimer(timeInterval: 1,
                                      target: self,
                                      selector: (#selector(ViewController.updateTimerr)),
                                      userInfo: nil, repeats: true)
    }
    
    @objc func updateTimerr() {
        
        if seconds < 1 {
             timer.invalidate()
             //Send alert to indicate "time's up!"
            print("timer end")
            self.dismiss(animated: true, completion: nil)
        } else {
             seconds -= 1
            timeLabel.text = "\(seconds)" //This will update the label.
            print("cardViews.count: ", cardViews.count)
            print("cards.count:  ", cards.count)
        }
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
                            UIViewPropertyAnimator.runningPropertyAnimator(
                                withDuration: 0.6,
                                delay: 0,
                                options: [],
                                animations: {
                                    cardsToAnimate.forEach {
                                        $0.transform = CGAffineTransform.identity.scaledBy(x: 2.0, y: 2.0)
                                    }
                            })
                            { (position) in
                                UIViewPropertyAnimator.runningPropertyAnimator(
                                    withDuration: 0.75,
                                    delay: 0,
                                    options: [],
                                    animations: {
                                        cardsToAnimate.forEach {
                                            $0.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
                                            $0.alpha = 0
                                        }
                                }) { (position) in
                                    self.cardViews.forEach { card in
//                                        card.removeFromSuperview()
                                        
                                    }
                                }
//                                { (position) in
//                                    cardsToAnimate.forEach {
//                                        $0.isHidden = true
//                                        $0.alpha = 1
//                                        $0.transform = .identity
//                                    }
//                                }
                            }
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                                print("queue 0.2")
//                                self.cardViews.removeLast()
//                                let cardViewsSlice = self.cardViews.suffix(2)
//                                print(cardViewsSlice)
//                                let range = self.cards.index(self.cards.endIndex, offsetBy: -2) ..< self.cards.endIndex
//                                var arraySlice = self.cards[range]
//                                arraySlice.removeAll()
//                                print(arraySlice)
//                                cardViewsSlice.removeAll()
//                                self.cardViews.removeLast()
//                                self.cardViews.removeLast()
                                
//                                self.cardViews.remove(at: index - 2)
//                                print(self.cards.count)
//                                print(self.faceUpCardViewsMatch)
                            print(self.faceUpCardViews.count)
//                            }
                            
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
                        } else if !chosenCardView.isFaceUp {
                                self.cardBehavior.addItem(chosenCardView)
                        } else {
                            if self.cardViews.count == 0 {
                                self.dismiss(animated: true, completion: nil)
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

