//
//  CustomizeView.swift
//  MorningBrew
//
//  Created by Sarthak Agrawal on 01/09/23.
//

import SwiftUI

struct CustomizeView: View {
    let drink: Drink
    let dismiss: () -> Void
    
    @EnvironmentObject var menu: Menu
    @EnvironmentObject var history: History
    
    @State private var size = 0
    @State private var isDecaf = false
    @State private var extraShot = 0
    @State private var milk = ConfigurationOption.none
    @State private var syrup = ConfigurationOption.none
    @State private var isFirstAppearance = true
    let sizeOptions = ["Small","Medium","Larger"]
    
    var caffeine: Int {
        var caffeineAmount = drink.caffeine[size]
        caffeineAmount += (extraShot * 60)
        
        if isDecaf{
            caffeineAmount /= 20
        }
        return caffeineAmount
    }
    
    var calories: Int{
        var calorieAmount = drink.baseCalories
        calorieAmount += extraShot * 10
        
        if drink.coffeeBased {
            calorieAmount += milk.calories
        }else{
            calorieAmount += milk.calories/8
        }
        
        calorieAmount += syrup.calories
        
        return calorieAmount * (size + 1)
    }
    
    
    var body: some View {
        Form{
            Section("Basic options"){
                Picker("Size",selection: $size){
                    ForEach(sizeOptions.indices){ index in
                        Text(sizeOptions[index])
                    }
                }
                .pickerStyle(.segmented)
                
                if drink.coffeeBased{
                    Stepper("Extra Shots: \(extraShot)", value: $extraShot, in: 0...8)
                }
                
                Toggle("Decaffeinated",isOn: $isDecaf)
            }
            
            Section("Customizations"){
                Picker("Milk",selection: $milk){
                    ForEach(menu.milkOptions){option in
                        Text(option.name)
                            .tag(option)
                    }
                }
                if drink.coffeeBased{
                    Picker("Syrup",selection: $syrup){
                        ForEach(menu.syrupOptions){ option in
                            Text(option.name)
                                .tag(option)
                        }
                    }
                }
            }
            
            Section("Estimates"){
                Text("**Caffeine:** \(caffeine) mg")
                Text("**Calories:** \(calories)")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(drink.name)
        .toolbar {
            Button("Save"){
                history.add(drink, size: sizeOptions[size], extraShots: extraShot, isDecaf: isDecaf, milk: milk, syrup: syrup, caffeine: caffeine, calorie: calories)
                
                dismiss()
            }
        }
        .onAppear{
            guard isFirstAppearance else{return}
            
            if drink.servedWithMilk{
                milk = menu.milkOptions[1]
            }
            
            isFirstAppearance = false
        }
    }
}

struct CustomizeView_Previews: PreviewProvider {
    static var previews: some View {
        CustomizeView(drink: Drink.example){}
            .environmentObject(Menu())
    }
}
