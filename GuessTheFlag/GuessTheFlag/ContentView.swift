//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kerem Yildirir on 16.08.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.15, green: 0.3, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 300, endRadius: 400)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag!")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .foregroundStyle(.secondary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 7)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer();Spacer()
                
                VStack {
                    Text("Your Score Is")
                        .foregroundStyle(.white)
                        .font(.title.bold())
                    
                    Text("...")
                        .foregroundStyle(.white)
                        .font(.largeTitle.bold())
                }
                
                Spacer()
            }
            .padding(20)
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: shuffle)
        } message: {
            Text("Your score is ...")
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
        }
        else{
            scoreTitle = "False"
        }
        
        showingScore = true
    }
    
    func shuffle(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
