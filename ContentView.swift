//
//  ContentView.swift
//  AutoColorDemo
//
//  Created by Galen Smith on 2/2/26.
//

import SwiftUI
import SwiftData


// version 1 with List {
// slowly push the entries "up" to see changes to column titles and header color change
// easier to see in landscape mode
// column titles - titles change to DARK mode color; white background to black;
// & green header contents - black to white

/*
struct ContentView: View {
    
    let date: Date
    let entries: [TravelEntries]
    
    @Environment(CategoryModel.self) private var categories
    @Environment(\.modelContext) var modelContext
    @Environment(\.verticalSizeClass) var vSizeClass
    
    // Use PersistentIdentifier (item.id) to uniquely map values to each row
    @State private var localCache: [PersistentIdentifier: String] = [:]
    @State private var homeCache: [PersistentIdentifier: String] = [:]
   
    var body: some View {
        
            List {

                Section(header: headerView()) {
                    ForEach(entries) { item in
                        if let local = localCache[item.id], let home = homeCache[item.id] {
                            transactionRow(item: item, local: local, home: home)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
                                .listRowBackground(Color.clear)
                            
                        } else {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                                .frame(height: 44)
                                .task { await fetchAndCache(item: item) }
                        }
                    }
                }
                
            }
            .listStyle(.plain)
            
            .navigationTitle(date.formatted(.dateTime.day().month().year()))
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.myTop, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
 */


 
 // version 2 with ScrollView
// added LazyVStack pinnedViews to fix the column titles from scrolling out-of-view
// titles behaving ok and the green header items change from color black to white

/*
struct ContentView: View {
    
    let date: Date
    let entries: [TravelEntries]
    
    @Environment(CategoryModel.self) private var categories
    @Environment(\.modelContext) var modelContext
    @Environment(\.verticalSizeClass) var vSizeClass
    
    // Use PersistentIdentifier (item.id) to uniquely map values to each row
    @State private var localCache: [PersistentIdentifier: String] = [:]
    @State private var homeCache: [PersistentIdentifier: String] = [:]
    
    var body: some View {
        
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 8, pinnedViews: .sectionHeaders) {
                Section(header: headerView()) {
                    ForEach(entries) { item in
                        if let local = localCache[item.id], let home = homeCache[item.id] {
                            transactionRow(item: item, local: local, home: home)
                            
                        } else {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                                .frame(height: 44)
                                .task { await fetchAndCache(item: item) }
                        }
                    }
                }
            }
        }
        .navigationTitle(date.formatted(.dateTime.day().month().year()))
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.myTop, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
    */


// version 3 with  .toolbarColorScheme(.light, for: .navigationBar)
// this prevents the header from change from black to white
// the column titles and green header now working as expected
 
struct ContentView: View {
    
    let date: Date
    let entries: [TravelEntries]
    
    @Environment(CategoryModel.self) private var categories
    @Environment(\.modelContext) var modelContext
    @Environment(\.verticalSizeClass) var vSizeClass
    
    // Use PersistentIdentifier (item.id) to uniquely map values to each row
    @State private var localCache: [PersistentIdentifier: String] = [:]
    @State private var homeCache: [PersistentIdentifier: String] = [:]
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 8, pinnedViews: .sectionHeaders) {
                Section(header: headerView()) {
                    ForEach(entries) { item in
                        if let local = localCache[item.id], let home = homeCache[item.id] {
                            transactionRow(item: item, local: local, home: home)
                                .padding(.horizontal, 12)
                        } else {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                                .frame(height: 44)
                                .task { await fetchAndCache(item: item) }
                        }
                    }
                }
            }
        }
        .navigationTitle(date.formatted(.dateTime.day().month().year()))
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.myTop, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.light, for: .navigationBar)
    }
 


    func headerView() -> some View {
        HStack(spacing: 0) {
            
            Text("Time/Category")
                .font(.headline)
                .fixedSize(horizontal: true, vertical: false)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
            
            if vSizeClass == .compact {
                Text("Description/Location")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            Text("Amount")
                .font(.headline)
                .fixedSize(horizontal: true, vertical: false)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 20)
        }
        .foregroundStyle(Color.myTitles)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }
    
    func transactionRow(item: TravelEntries, local: String, home: String) -> some View {
        Group {
            HStack(alignment: .center, spacing: 0) {
                
                // 1st column: date & category
                VStack(alignment: .leading, spacing: 4) {
                    Text(formatDate(item: item, timeOnly: true, mnWide: false))
                        .font(.body)
                        .fixedSize(horizontal: true, vertical: false)
                    
                    Text(item.entryCatName)
                        .font(.caption)
                        .fixedSize(horizontal: true, vertical: false)
                }
                .foregroundStyle(.white)
                .padding(.leading, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Middle Column: description & location (Landscape)
                if vSizeClass == .compact {
                    VStack(alignment: .center, spacing: 4) {
                        Text(item.entryDsc)
                        
                        Text("\(item.entryCity) \(item.entryCountry)")
                            .font(.caption)
                            .lineLimit(1)
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                
                // 3rd Column: local & home currency
                VStack(alignment: .trailing, spacing: 4) {
                    Text(local)
                        .fixedSize(horizontal: true, vertical: false)
                    
                    if item.entryCode != "USD"  {
                        Text(home)
                            .font(.caption)
                            .fixedSize(horizontal: true, vertical: false)
                    }
                }
                .foregroundStyle(.white)
                .padding(.trailing, 20)
                .frame(maxWidth: .infinity, alignment: .trailing)
                
            }
            .frame(height: 42)
            .padding(.vertical, 8)
            .padding(.horizontal, 8)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.myText))
        }
    }
    
    private func fetchAndCache(item: TravelEntries) async {
        // This function only updates THIS row's @State
        let minorDigitsL = categories.findMinorDigits(contCode: item.entryCode)
        let localCurrency = categories.adjCurrencyOutput(entry: item.entryMoneyL)
        let formattedLocal = localCurrency.formatted(.currency(code: item.entryCode).precision(.fractionLength(minorDigitsL)))
        
        let minorDigitsH = categories.findMinorDigits(contCode: "USD")
        let homeCurrency = categories.adjCurrencyOutput(entry: item.entryMoneyH)
        let formattedHome = homeCurrency.formatted(.currency(code: "USD").precision(.fractionLength(minorDigitsH)))
        
        // Updating MainActor-isolated properties from a task
        await MainActor.run {
            localCache[item.id] = formattedLocal
            homeCache[item.id] = formattedHome
        }
    }
}


#Preview {
    
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: TravelEntries.self, configurations: config)
    
    let samples = TravelEntries.sampleData
    let demoDate = TravelEntries.demoDate
    
    NavigationStack {
        ContentView(date: demoDate, entries: samples)
            .modelContainer(container)
            .environment(CategoryModel())
    }
}









