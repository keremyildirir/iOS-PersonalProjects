//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Kerem Yildirir on 6.10.2024.
//

import SwiftUI

struct HabitDetailView: View {
    @ObservedObject var viewModel: HabitsViewModel
    var habit: Habit
    
    var body: some View {
        VStack(spacing: 20) {
            // Description of the habit
            Text(habit.description)
                .font(.body)
                .padding()
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
            
            // Completion count display with Stepper
            VStack(spacing: 10) {
                Text("Completion Count")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Stepper(value: Binding(
                    get: {
                        habit.completionCount
                    },
                    set: { newValue in
                        if newValue >= 0 {
                            viewModel.incrementCompletionCount(for: habit, by: newValue - habit.completionCount)
                        }
                    }
                ), in: 0...100) {
                    Text("\(habit.completionCount)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue, lineWidth: 2))
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle(habit.title)
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}


