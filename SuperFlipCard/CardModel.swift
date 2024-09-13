//
//  CardModel.swift
//  SuperFlipCard
//
//  Created by Younis on 9/12/24.
//

import Foundation


struct Card: Identifiable {
    let id = UUID()
    let emoji: String
    var isMatched = false
    var isFaceUp = false
}
