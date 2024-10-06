//
//  HabitsViewModel.swift
//  HabitTracker
//
//  Created by Kerem Yildirir on 6.10.2024.
//

import Foundation

class HabitsViewModel: ObservableObject {
    @Published var habits: [Habit] = [] {
        didSet {
            saveHabits() // Save habits whenever they change
        }
    }
    
    private let USER_DEFAULTS_KEY = "SavedHabits"
    
    init() {
        habits = loadHabits()  // Load habits after initialization
    }
    
    func addHabit(title: String, description: String) {
        let newHabit = Habit(title: title, description: description, completionCount: 0)
        habits.append(newHabit)
    }

    func incrementCompletionCount(for habit: Habit, by value: Int) {
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            habits[index].completionCount += value
        }
    }
    
    func deleteHabit(at offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
    }

    // MARK: - Saving and Loading
    
    private func saveHabits() {
        if let encoded = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.set(encoded, forKey: USER_DEFAULTS_KEY)
        }
    }
    
    private func loadHabits() -> [Habit] {
        if let savedHabitsData = UserDefaults.standard.data(forKey: USER_DEFAULTS_KEY) {
            if let decodedHabits = try? JSONDecoder().decode([Habit].self, from: savedHabitsData) {
                return decodedHabits
            }
        }
        return []
    }
}

