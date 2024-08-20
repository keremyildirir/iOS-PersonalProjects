//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Kerem Yildirir on 20.08.2024.
//

import SwiftUI

struct ContentView: View {

    let moves = ["🪨", "📄", "✂️"]
    
    @State private var appMove = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var round = 1
    
    @State private var showingScore = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Round \(round) of 10")
                .font(.largeTitle)
            
            Text("App chose: \(moves[appMove])")
                .font(.title)
            
            Text("You need to \(shouldWin ? "Win" : "Lose")")
                .font(.title2)
            
            HStack {
                ForEach(0..<3) { number in
                    Button(action: {
                        self.playerTapped(number)
                    }) {
                        Text(self.moves[number])
                            .font(.system(size: 45))
                    }
                }
            }
            
            Text("Score: \(score)")
                .font(.title)
                .padding()
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(score >= 7 ? "Well Done!" : "Game Over"), message: Text("Your final score is \(score)"), dismissButton: .default(Text("Restart")) {
                self.resetGame()
            })
        }
    }
    
    func playerTapped(_ number: Int) {
        let winningMove = (appMove + 1) % 3
        let losingMove = (appMove + 2) % 3
        
        if (shouldWin && number == winningMove) || (!shouldWin && number == losingMove) {
            score += 1
        }
        
        if round == 10 {
            showingScore = true
        } else {
            round += 1
            appMove = Int.random(in: 0...2)
            shouldWin = Bool.random()
        }
    }
    
    func resetGame() {
        score = 0
        round = 1
        appMove = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
}

#Preview {
    ContentView()
}
