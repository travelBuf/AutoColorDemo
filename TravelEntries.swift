//
//  TravelEntries.swift
//  AutoColorDemo
//
//  Created by Galen Smith on 2/2/26.
//

import Foundation
import SwiftData
import CoreLocation

// entry SwiftData model
@Model final class TravelEntries: Identifiable {
    var entryDate: Date             // transaction date
    var entryCatName: String        // transaction category name
    var entryCode: String           // transaction currency 3 character code
    var entryCurCountry: String     // transaction currency country
    var entryDsc: String            // transaction description
    var entryMoneyL: Int            // transaction amount in local currency
    var entryMoneyH: Int            // transaction amount in home currency
    var entryCity: String           // city and sometimes country
    var entryCountry: String        // full country name
    var entryCN2: String            // 2 digit country name

     init(entryDate: Date, entryCatName: String, entryCode: String, entryCurCountry: String, entryDsc: String, entryMoneyL: Int, entryMoneyH: Int, entryCity: String, entryCountry: String, entryCN2: String) {
        self.entryDate = entryDate
        self.entryCatName = entryCatName
        self.entryCode = entryCode
        self.entryCurCountry = entryCurCountry
        self.entryDsc = entryDsc
        self.entryMoneyL = entryMoneyL
        self.entryMoneyH = entryMoneyH
        self.entryCity = entryCity
        self.entryCountry = entryCountry
        self.entryCN2 = entryCN2
    }
}



extension TravelEntries {
    // The exact day all demo entries will occur on
    static let demoDate: Date = {
        var components = DateComponents()
        components.year = 2024
        components.month = 5
        components.day = 24
        return Calendar.current.date(from: components)!
    }()

    @MainActor      // fake sample data
    static var sampleData: [TravelEntries] {
            let baseDate = TravelEntries.demoDate 
            return [
                TravelEntries(entryDate: baseDate.addingTimeInterval(3600), entryCatName: "Food", entryCode: "EUR", entryCurCountry: "France", entryDsc: "Croissant & Coffee", entryMoneyL: 1250, entryMoneyH: 1700, entryCity: "Paris", entryCountry: "France", entryCN2: "FR"),
                          
                TravelEntries(entryDate: baseDate.addingTimeInterval(4500), entryCatName: "Lodging", entryCode: "EUR", entryCurCountry: "France", entryDsc: "Croissant & Coffee", entryMoneyL: 325000, entryMoneyH: 383370, entryCity: "Paris", entryCountry: "France", entryCN2: "FR"),
                
                TravelEntries(entryDate: baseDate.addingTimeInterval(5400), entryCatName: "Sightseeing", entryCode: "EUR", entryCurCountry: "France", entryDsc: "Eiffel Tower", entryMoneyL: 36700, entryMoneyH: 43290, entryCity: "Paris", entryCountry: "France", entryCN2: "FR"),
                
                
                TravelEntries(entryDate: baseDate.addingTimeInterval(7200), entryCatName: "Local Transit", entryCode: "GBP", entryCurCountry: "UK", entryDsc: "London Tube", entryMoneyL: 2800, entryMoneyH: 3820, entryCity: "London", entryCountry: "United Kingdom", entryCN2: "GB"),
                          
                TravelEntries(entryDate: baseDate.addingTimeInterval(8100), entryCatName: "Laundry", entryCode: "GBP", entryCurCountry: "UK", entryDsc: "Wash & Dry", entryMoneyL: 12000, entryMoneyH: 16400, entryCity: "London", entryCountry: "United Kingdom", entryCN2: "GB"),

                TravelEntries(entryDate: baseDate.addingTimeInterval(9000), entryCatName: "Entertainment", entryCode: "GBP", entryCurCountry: "UK", entryDsc: "Show", entryMoneyL: 135000, entryMoneyH: 184530, entryCity: "London", entryCountry: "United Kingdom", entryCN2: "GB"),
                
                
                TravelEntries(entryDate: baseDate.addingTimeInterval(10800), entryCatName: "Lodging", entryCode: "JPY", entryCurCountry: "Japan", entryDsc: "Capsule Hotel", entryMoneyL: 32500000, entryMoneyH: 208960, entryCity: "Tokyo", entryCountry: "Japan", entryCN2: "JP"),
                          
                TravelEntries(entryDate: baseDate.addingTimeInterval(11700), entryCatName: "Ferry", entryCode: "JPY", entryCurCountry: "Japan", entryDsc: "Ferry", entryMoneyL: 4200000, entryMoneyH: 27000, entryCity: "Tokyo", entryCountry: "Japan", entryCN2: "JP"),
                
                TravelEntries(entryDate: baseDate.addingTimeInterval(12600), entryCatName: "Food", entryCode: "JPY", entryCurCountry: "Japan", entryDsc: "", entryMoneyL: 8500000, entryMoneyH: 54680, entryCity: "Tokyo", entryCountry: "Japan", entryCN2: "JP"),
                
                
                TravelEntries(entryDate: baseDate.addingTimeInterval(14400), entryCatName: "Entertainment", entryCode: "USD", entryCurCountry: "USA", entryDsc: "Museum Ticket", entryMoneyL: 135000, entryMoneyH: 135000, entryCity: "Las Vegas", entryCountry: "United States", entryCN2: "US"),
                
                TravelEntries(entryDate: baseDate.addingTimeInterval(15300), entryCatName: "Train", entryCode: "USD", entryCurCountry: "USA", entryDsc: "Museum Ticket", entryMoneyL: 85000, entryMoneyH: 85000, entryCity: "Las Vegas", entryCountry: "United States", entryCN2: "US"),

                TravelEntries(entryDate: baseDate.addingTimeInterval(16200), entryCatName: "Car Rental", entryCode: "USD", entryCurCountry: "USA", entryDsc: "Museum Ticket", entryMoneyL: 225000, entryMoneyH: 225000, entryCity: "Las Vegas", entryCountry: "United States", entryCN2: "US"),
        ]
    }
}
