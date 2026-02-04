//
//  CategoryModel.swift
//  AutoColorDemo
//
//  Created by Galen Smith on 2/2/26.
//


import SwiftUI
import Observation


@MainActor
@Observable final class CategoryModel {
        
    
    /*---------------------------------------
     determine number of minor currency digits
     given the currency code
     ---------------------------------------*/
    func findMinorDigits(contCode: String) -> (Int) {
        
        for i in 0..<currencyList.count {
            
            if contCode.caseInsensitiveCompare(currencyList[i].code) == .orderedSame {
                return currencyList[i].minor
            }
        }
        return 2  // use 2 if problem finding minor digits for this currency
    }
    
    /*-------------------------------------------------------------
     adjust local currency output for display
    -------------------------------------------------------------*/
    func adjCurrencyOutput(entry: Int) -> (Double) {

        return Double(entry) / 1000
    }
}

 
