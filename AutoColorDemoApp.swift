//
//  AutoColorDemoApp.swift
//  AutoColorDemo
//
//  Created by Galen Smith on 2/2/26.
//

import SwiftUI
import SwiftData

@main
struct AutoColorDemoApp: App {
    
    @State private var categories = CategoryModel()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView(date: Date.now, entries: TravelEntries.sampleData)
                    .environment(categories)
            }
        }
        .modelContainer(for: TravelEntries.self)
    }
}
