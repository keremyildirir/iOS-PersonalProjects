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
        VStack {
            Text(habit.description)
                .font(.body)
                .padding()
                        
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
                Text("Completion Count: \(habit.completionCount)")
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle(habit.title)
        .padding()
    }
}

