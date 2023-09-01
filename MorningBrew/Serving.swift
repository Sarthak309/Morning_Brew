//
//  Serving.swift
//  MorningBrew
//
//  Created by Sarthak Agrawal on 01/09/23.
//

import Foundation

struct Serving: Identifiable, Codable, Equatable{
    var id: UUID
    let name: String
    let description: String
    let caffeine: Int
    let calories: Int
    
}
