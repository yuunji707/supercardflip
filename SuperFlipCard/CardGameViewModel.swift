//
//  CardGameViewModel.swift
//  SuperFlipCard
//
//  Created by Younis on 9/12/24.
//

import Foundation

class CardGameViewModel: ObservableObject {
    @Published private(set) var cards: [Card] = []
    @Published private(set) var score = 0
    
    private var firstFlippedCardIndex: Int?
    private let emojis = ["🍎", "🚗", "🌈", "🎸", "🐘", "🍕", "⚽️", "🌺"]
    init() {
        resetGame()
    }
    
    func resetGame() {
        let shuffledEmojis = (emojis + emojis).shuffled()
        cards = shuffledEmojis.map { Card(emoji: $0) }
        score = 0
        firstFlippedCardIndex = nil
    }
    
    func flipCard(at index: Int) {
        guard index < cards.count && !cards[index].isMatched && !cards[index].isFaceUp else { return }
        
        cards[index].isFaceUp = true
        
        if let firstIndex = firstFlippedCardIndex {
            checkForMatch(firstIndex: firstIndex, secondIndex: index)
            firstFlippedCardIndex = nil
        } else {
            firstFlippedCardIndex = index
        }
    }
    
    private func checkForMatch(firstIndex: Int, secondIndex: Int) {
        if cards[firstIndex].emoji == cards[secondIndex].emoji {
            cards[firstIndex].isMatched = true
            cards[secondIndex].isMatched = true
            score += 2
        } else {
            score -= 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.cards[firstIndex].isFaceUp = false
                self.cards[secondIndex].isFaceUp = false
            }
        }
    }
}

