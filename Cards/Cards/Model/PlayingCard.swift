//
//  PlayingCard.swift
//  Cards
//
//  Created by wtildestar on 09/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import Foundation

struct PlayingCard: CustomStringConvertible {
    
    // MARK: - Properties
    
    var suit: Suit
    var rank: Rank
    
    var description: String { return "\(rank) \(suit)" }
    
    enum Suit: String, CustomStringConvertible {
        case spades = "♠️"
        case hearts = "♥️"
        case clubs = "♣️"
        case diamonds = "♦️"
        
        static var all: [Suit] {
            return [.spades, .hearts, .clubs, .diamonds]
        }
        var description: String { return self.rawValue }
    }
    
    enum Rank: CustomStringConvertible {
    
        case ace
        case face(String)
        case numeric(Int)
        
        var order: Int {
            switch self {
            case .ace: return 1
            case .numeric(let pips): return pips
            case .face(let kind) where kind == "J": return 11
            case .face(let kind) where kind == "Q": return 12
            case .face(let kind) where kind == "K": return 13
            default: return 0
            }
        }
        
        static var all: [Rank] {
            var allRanks = [Rank.ace]
            for pips in 2...10 {
                allRanks.append(Rank.numeric(pips))
            }
            allRanks += [Rank.face("J"), .face("Q"), .face("K")]
            return allRanks
        }
        
        var description: String {
            switch self {
            case .ace: return "ace \(self.order)"
            case .face(let kind): return "face \(kind) \(self.order)"
            case .numeric: return "numeric \(self.order)"
            }
            
        }
    }
    
}
