//
//  ConfigurationOption.swift
//  MorningBrew
//
//  Created by Sarthak Agrawal on 01/09/23.
//

import Foundation
struct ConfigurationOption: Identifiable, Codable, Hashable{
    let id: UUID
    let name: String
    let calories: Int
    
    static let none = ConfigurationOption(id: UUID(), name: "None", calories: 0)
    
    
}
