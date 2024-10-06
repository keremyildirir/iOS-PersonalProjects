//
//  ContentView.swift
//  HabitTracker
//
//  Created by Kerem Yildirir on 6.10.2024.
//

import SwiftUI

struct Habit: Identifiable, Codable {
    let id = UUID()
    let title: String
    let description: String
    var completionCount: Int = 0
}

struct ContentView: View {
    @StateObject var viewModel = HabitsViewModel()
    @State private var showingAddHabit = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.habits) { habit in
                    NavigationLink(destination: HabitDetailView(viewModel: viewModel, habit: habit)) {
                        VStack(alignment: .leading) {
                            Text(habit.title)
                                .font(.headline)
                            Text(habit.description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddHabit.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                AddHabitView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
