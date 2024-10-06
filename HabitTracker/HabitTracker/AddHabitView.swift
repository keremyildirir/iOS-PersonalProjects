//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Kerem Yildirir on 6.10.2024.
//

import SwiftUI

struct AddHabitView: View {
    @ObservedObject var viewModel: HabitsViewModel
    @State private var title = ""
    @State private var description = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add New Habit")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.addHabit(title: title, description: description)
                        dismiss()
                    }
                }
            }
        }
    }
}

