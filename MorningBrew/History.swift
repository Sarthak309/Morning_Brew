//
//  History.swift
//  MorningBrew
//
//  Created by Sarthak Agrawal on 01/09/23.
//

import Foundation

class History: ObservableObject{
    @Published var servings: [Serving]
    
    let savePath = FileManager.documentDirectory.appendingPathComponent("SavedDrinks")
    
    init(){
        do{
            let data = try Data(contentsOf: savePath)
            servings = try JSONDecoder().decode([Serving].self, from: data)
        } catch{
            servings = []
        }
    }
    
    func save(){
        do{
            let data = try JSONEncoder().encode(servings)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch{
            print("Unable to save data")
        }
    }
    
    func add(_ drink: Drink, size: String, extraShots: Int, isDecaf: Bool, milk: ConfigurationOption, syrup: ConfigurationOption, caffeine: Int, calorie: Int){
        var description = [String]()
        description.append(size)
        if isDecaf{
            description.append("decaffeinated")
        }
        
        if(extraShots == 0){
            description.append("No Extra Shots")
        }else{
            description.append("\(extraShots) Extra Shots")
        }
        
        if milk != .none{
            description.append("\(milk.name.lowercased()) Milk")
        }
        
        if syrup != .none{
            description.append("\(syrup.name.lowercased()) Syrup")
        }
        
        let descriptionString = description.joined(separator: ", ")
        
        let serving = Serving(id: UUID(), name: drink.name, description: descriptionString, caffeine: caffeine, calories: calorie)
        servings.insert(serving, at: 0)
        save()
       
    }
    
    func reorder(_ serving: Serving){
        var copy = serving
        copy.id = UUID()
        servings.insert(copy, at: 0)
        save()
    }
    
    func delete(_ serving: Serving){
        if let index = servings.firstIndex(of: serving){
            servings.remove(at: index)
            save()
         }
    }
    
}
