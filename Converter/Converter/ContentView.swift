//
//  ContentView.swift
//  Converter
//
//  Created by Kerem Yildirir on 16.08.2024.
//

import SwiftUI

struct ContentView: View {
    
    private let metrics = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]
    
    @State private var inputLength = 0.0
    @State private var outputLength = 0.0
    
    @State private var inputMetric: String
    @State private var outputMetric: String
    
    @FocusState private var isFocused: Bool
    
    init() {
        _inputMetric = State(initialValue: metrics.first ?? "")
        _outputMetric = State(initialValue: metrics.first ?? "")
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Picker("Input Metric", selection: $inputMetric){
                        ForEach(metrics, id: \.self){
                            Text($0)
                        }
                    }
                    .onChange(of: inputMetric) {
                        convert()
                    }
                }
                
                Section{
                    Picker("Output Metric", selection: $outputMetric){
                        ForEach(metrics, id: \.self){
                            Text($0)
                        }
                    }
                    .onChange(of: outputMetric) {
                        convert()
                    }
                }
                
                Section("Input Length"){
                    TextField("Enter length", value: $inputLength, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                        .onChange(of: inputLength) {
                            convert()
                        }
                }
                Section("Output Length"){
                    Text("\(outputLength, specifier: "%.2f")")
                }
            }.navigationTitle("Converter")
                .toolbar{
                    if isFocused{
                        Button("Done"){
                            isFocused = false
                        }
                    }
                }
        }
    }
    
    // Conversion function
    func convert() {
        let inputInMeters: Double
        
        // Convert the input to meters
        switch inputMetric {
        case "Meters":
            inputInMeters = inputLength
        case "Kilometers":
            inputInMeters = inputLength * 1000
        case "Feet":
            inputInMeters = inputLength * 0.3048
        case "Yards":
            inputInMeters = inputLength * 0.9144
        case "Miles":
            inputInMeters = inputLength * 1609.34
        default:
            inputInMeters = 0.0
        }
        
        // Convert from meters to the output metric
        switch outputMetric {
        case "Meters":
            outputLength = inputInMeters
        case "Kilometers":
            outputLength = inputInMeters / 1000
        case "Feet":
            outputLength = inputInMeters / 0.3048
        case "Yards":
            outputLength = inputInMeters / 0.9144
        case "Miles":
            outputLength = inputInMeters / 1609.34
        default:
            outputLength = 0.0
        }
    }
}

#Preview {
    ContentView()
}
