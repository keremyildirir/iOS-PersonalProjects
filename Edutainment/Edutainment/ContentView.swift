//
//  ContentView.swift
//  Edutainment
//
//  Created by Kerem Yildirir on 27.08.2024.
//

import SwiftUI

struct Question {
    let text: String
    let answer: Int
}

struct ContentView: View {
    
    @State private var borderNumber = 2
    @State private var questionNumber = 5
    @State private var questions: [Question] = []
    @State private var currentQuestionIndex = 0
    @State private var userAnswer: String = ""
    @State private var isGameStarted = false
    @State private var showAlert = false
    @State private var showFinalAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    @State private var score = 0
    
    private let questionNumbers = [5, 10, 20]
    
    var body: some View {
        NavigationView{
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 1.0, green: 0.8, blue: 0.3), // Bright yellow-orange
                        Color(red: 0.5, green: 0.8, blue: 0.9), // Soft sky blue
                        Color(red: 0.9, green: 0.6, blue: 0.9), // Light lavender pink
                        Color(red: 0.6, green: 0.9, blue: 0.5)  // Bright mint green
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                if isGameStarted {
                    VStack {
                        Text(questions[currentQuestionIndex].text)
                            .font(.title)
                            .padding()
                        
                        TextField("Enter your answer", text: $userAnswer)
                            .keyboardType(.numberPad)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                            .padding(.horizontal)
                            .font(.title3)
                            .foregroundColor(.black)
                        
                        Button(action: checkAnswer) {
                            Text("Submit Answer")
                                .font(.title3)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .shadow(radius: 10)
                                .padding(.top, 10)
                        }
                    }
                    .padding()
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Settings") {
                                restart()
                            }
                        }
                    }
                } else {
                    VStack(alignment: .leading) {
                        Text("Max number for multiplication")
                            .font(.headline)
                        
                        Stepper("Up to \(borderNumber)", value: $borderNumber, in: 2...12)
                            .padding(.top, 2)
                        
                        Text("Number of questions")
                            .font(.headline)
                            .padding(.top, 10)
                        
                        Picker("Number of questions", selection: $questionNumber) {
                            ForEach(questionNumbers, id: \.self) { number in
                                Text("\(number)")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.top, 10)
                        
                        Button(action: start) {
                            Text("Let's Start!")
                                .font(.title2)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .shadow(radius: 10)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 50)
                    }
                    .padding()
                }
            }
            .alert(alertTitle, isPresented: $showAlert) {
                Button("Continue", action: nextQuestion)
            } message: {
                Text(alertMessage)
            }
            .alert(alertTitle, isPresented: $showFinalAlert) {
                Button("Restart", action: nextQuestion)
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private func start() {
        questions.removeAll()
        for _ in 0..<questionNumber {
            let number1 = Int.random(in: 1...borderNumber)
            let number2 = Int.random(in: 1...9)
            let question = Question(text: "What is \(number1) x \(number2)?", answer: number1 * number2)
            questions.append(question)
        }
        
        // Start the game
        currentQuestionIndex = 0
        userAnswer = ""
        isGameStarted = true
    }
    
    private func checkAnswer() {
        guard let userAnswerInt = Int(userAnswer) else { return }
        let correctAnswer = questions[currentQuestionIndex].answer
        if userAnswerInt == correctAnswer {
            alertTitle = "Correct"
            alertMessage = "Well Done!"
            score += 1
        } else {
            alertTitle = "Incorrect"
            alertMessage = "The correct answer was \(correctAnswer)."
        }
        
        if currentQuestionIndex < questions.count - 1 {
            showAlert = true
        } else {
            alertMessage = "You've completed all the questions! Score: \(score) / \(questionNumber)"
            showFinalAlert = true
        }
    }
    
    private func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            userAnswer = ""
            showAlert = true
        } else {
            restart()
        }
    }
    
    private func restart(){
        isGameStarted = false
        questions.removeAll()
        currentQuestionIndex = 0
        score = 0
    }
}

#Preview {
    ContentView()
}

