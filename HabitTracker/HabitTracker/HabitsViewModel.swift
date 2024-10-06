//
//  HabitsViewModel.swift
//  HabitTracker
//
//  Created by Kerem Yildirir on 6.10.2024.
//

import Foundation

class HabitsViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    
    func addHabit(title: String, description: String) {
        let newHabit = Habit(title: title, description: description)
        habits.append(newHabit)
    }
    
    func incrementCompletionCount(for habit: Habit) {
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            habits[index].completionCount += 1
        }
    }
}
