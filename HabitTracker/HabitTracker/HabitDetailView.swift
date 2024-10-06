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
            
            Text("Completion Count: \(habit.completionCount)")
                .font(.headline)
                .padding()
            
            Button(action: {
                viewModel.incrementCompletionCount(for: habit)
            }) {
                Text("Increment Completion Count")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Spacer()
        }
        .navigationTitle(habit.title)
        .padding()
    }
}
