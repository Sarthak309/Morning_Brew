//
//  Menu.swift
//  MorningBrew
//
//  Created by Sarthak Agrawal on 01/09/23.
//

import Foundation
class Menu: ObservableObject, Codable{
    let sections: [MenuSection]
    var milkOptions = [ConfigurationOption.none]
    var syrupOptions = [ConfigurationOption.none]
    
    
    init(){
        do{
            let url = Bundle.main.url(forResource: "menu", withExtension: "json")!
            let data = try Data(contentsOf: url)
            let menuData = try JSONDecoder().decode(Menu.self, from: data)
            
            sections = menuData.sections
            milkOptions.append(contentsOf: menuData.milkOptions)
            syrupOptions.append(contentsOf: menuData.syrupOptions)
            

            
        }catch{
            fatalError("menu.json is missing or corrupt.")
        }
    }
}
