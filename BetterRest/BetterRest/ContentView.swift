//
//  ContentView.swift
//  BetterRest
//
//  Created by Kerem Yildirir on 21.08.2024.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("When do you want to wake up?")
                    .font(.headline)
                    .foregroundColor(.white)) {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                Section(header: Text("Desired amount of sleep")
                    .font(.headline)
                    .foregroundColor(.white)) {
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                Section(header: Text("Daily coffee intake")
                    .font(.headline)
                    .foregroundColor(.white)) {
                    Picker("Number of cups", selection: $coffeeAmount) {
                        ForEach(1..<21) {
                            Text("\($0) cup\($0 > 1 ? "s" : "")")
                        }
                    }
                }
                
                Section(header: Text("Your recommended bedtime is")
                    .font(.headline)
                    .foregroundColor(.white)) {
                    Text(calculateBedtime())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
            }
            .navigationTitle("BetterRest")
            
            // Make sure background color is visible
            .background(Color.clear)
            .scrollContentBackground(.hidden)
            
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 1.0, green: 0.7, blue: 0.4), // Warm orange
                        Color(red: 0.9, green: 0.5, blue: 0.5), // Softened pink
                        Color(red: 0.75, green: 0.45, blue: 0.65) // Mellow purple
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )

        }
    }
    
    func calculateBedtime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            return sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return "Error calculating bedtime."
        }
    }
}

#Preview {
    ContentView()
}
