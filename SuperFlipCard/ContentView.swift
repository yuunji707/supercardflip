//
//  ContentView.swift
//  SuperFlipCard
//
//  Created by Younis on 9/12/24.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue, lineWidth: 2)
                Text(card.emoji)
                    .font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
            }
        }
    }
}

struct ContentView: View {
    @StateObject private var viewModel = CardGameViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Emoji Memory Game")
                    .font(.largeTitle)
                    .padding(.top, 40)
                
                Text("Score: \(viewModel.score)")
                    .font(.title2)
                
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.cards.indices, id: \.self) { index in
                        CardView(card: viewModel.cards[index])
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.flipCard(at: index)
                            }
                    }
                }
                .padding(.horizontal)
                
                Spacer(minLength: 20)
                
                Button("New Game") {
                    viewModel.resetGame()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Spacer(minLength: 40)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

