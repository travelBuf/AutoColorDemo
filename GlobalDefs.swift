//
//  GlobalDefs.swift
//  AutoColorDemo
//
//  Created by Galen Smith on 2/2/26.
//

import Foundation
import SwiftUI


extension View {
    

    /*---------------------------------------
     format date to the original timezone (like photos app)
     ---------------------------------------*/
    func formatDate(item: TravelEntries, timeOnly: Bool, mnWide: Bool ) -> String {
        
        let d = item.entryDate
            // time only
            let f = Date.FormatStyle.dateTime.hour().minute()
            
            return d.formatted(f)
    }
}


struct CurrencyList: Identifiable, Hashable, Equatable {
    let id = UUID()
    let code: String
    let emoji: String
    let minor: Int
    let symbol: String
    let name: String
    let country: String
}

let currencyList = [
    
    CurrencyList(code: "USD", emoji: "US", minor: 2, symbol: "$", name: "Dollar", country: String(localized: "United States")),
    CurrencyList(code: "EUR", emoji: "FR", minor: 2, symbol: "€", name: "Euro", country:  String(localized: "France")),
    CurrencyList(code: "JPY", emoji: "JP", minor: 0, symbol: "¥", name: "Yen", country: String(localized: "Japan")),
    CurrencyList(code: "GBP", emoji: "GB", minor: 2, symbol: "£", name: "Pound", country: String(localized: "United Kingdom")),
    ]

extension Array where Element == CurrencyList {
    subscript (countryCode: String) -> Element? {
        self.first { country in
            country.code == countryCode
        }
    }
}



