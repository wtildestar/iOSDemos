//
//  PlayingCardViewExtension.swift
//  Cards
//
//  Created by wtildestar on 09/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

extension PlayingCardView {
    static func ==(lhs: PlayingCardView, rhs: PlayingCardView) -> Bool {
        return lhs.rank == rhs.rank && lhs.suit == rhs.suit
    }
}

extension PlayingCardView {
    
    @available(iOS 10.0, *)
    func cardsMatchAnimation(completion: (() -> Swift.Void)? = nil)  {
        let animator = UIViewPropertyAnimator(
            duration: Constants.matchCardAnimationDuration,
            curve: .linear ,
            animations: {
                self.center = self.superview!.center
                self.transform = CGAffineTransform.identity.scaledBy(x: Constants.matchCardAnimationScaleUp,
                                                                     y: Constants.matchCardAnimationScaleUp)
            })
        animator.addCompletion({ position in
            UIViewPropertyAnimator.runningPropertyAnimator(
                withDuration: Constants.matchCardAnimationDuration,
                delay: 0, options: [],
                animations: {
                    self.transform = CGAffineTransform.identity.scaledBy(x: Constants.matchCardAnimationScaleDown,
                                                                         y: Constants.matchCardAnimationScaleDown)
                    self.alpha = 0
                },
                completion: { position in
                    self.isHidden = true
                    self.alpha = 1
                    self.transform = .identity
                }
            )
        })
        animator.addCompletion({ position in
            completion?()
        })
        animator.startAnimation()
    }
    
    func flipCard(completion: (() -> Swift.Void)? = nil)  {
        UIView.transition(
            with: self,
            duration: Constants.flipCardAnimationDuration,
            options: [.transitionFlipFromLeft],
            animations: { self.isFaceUp = !self.isFaceUp },
            completion: { position in
                completion?()
            }
        )
    }
}
