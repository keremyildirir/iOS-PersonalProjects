//
//  addView.swift
//  iExpense
//
//  Created by Kerem Yildirir on 2.09.2024.
//

import SwiftUI

struct addView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var title = "Expense Title"
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    var expenses: Expenses

    let types = ["Business", "Personal"]

    var body: some View {
        NavigationStack {
            Form {
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: title, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    addView(expenses: Expenses())
}
