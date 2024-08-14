//
//  ContentView.swift
//  WeSplit
//
//  Created by Kerem Yildirir on 14.08.2024.
//

import SwiftUI

struct ContentView: View {
    
    let colleagues = ["Zeynep", "Melih", "Eyüp", "Samet"]
    @State private var selectedColleague = "None"
    var body: some View {
        NavigationStack{
            Form{
                Picker("Select Colleague", selection: $selectedColleague){
                    ForEach(colleagues, id: \.self){
                        Text($0)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

