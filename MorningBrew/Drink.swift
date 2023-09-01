//
//  Drink.swift
//  MorningBrew
//
//  Created by Sarthak Agrawal on 01/09/23.
//

import Foundation

struct Drink: Identifiable, Codable{
    let id: UUID
    let name: String
    let caffeine: [Int]
    let coffeeBased: Bool
    let servedWithMilk: Bool
    let baseCalories: Int
    
    var image: String{
        name.lowercased().replacingOccurrences(of: " ", with: "-")
    }
    
    static let example = Drink(id: UUID(), name: "Sarthak",caffeine: [60,120,200],coffeeBased: true,servedWithMilk: true,baseCalories: 100)
    
}
