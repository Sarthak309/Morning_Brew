//
//  ContentView.swift
//  MorningBrew
//
//  Created by Sarthak Agrawal on 01/09/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var menu = Menu()
    @StateObject var history = History()
    @State private var showingAddScrenn = false
    
    var totalCaffeine: Int{
        history.servings.map(\.caffeine).reduce(0, +)
    }
    
    var totalCalories: Int{
        history.servings.map(\.calories).reduce(0, +)
    }
    
    var body: some View {
        NavigationView{
            List{
                if history.servings.isEmpty{
                    Button("Add your first drink"){
                        showingAddScrenn = true
                    }
                    .buttonStyle(.plain)
                }else{
                    Section("Summary"){
                        Text("Caffeine: \(totalCaffeine)")
                        Text("Calories: \(totalCalories)")
                    }
                    ForEach(history.servings){serving in
                        HStack{
                            VStack(alignment: .leading){
                                Text(serving.name)
                                    .font(.headline)
                                Text(serving.description)
                                    .font(.caption)
                            }
                            Spacer()
                            
                            Text("\(serving.caffeine) mg")
                        }
                        .swipeActions(edge: .leading,allowsFullSwipe: true){
                            Button{
                                withAnimation{
                                    history.reorder(serving)
                                }
                            } label: {
                                Label("Repeat", systemImage: "repeat")
                            }
                        }
                        .tint(.blue)
                        
                        .swipeActions(edge: .trailing, allowsFullSwipe: true){
                            Button(role: .destructive){
                                withAnimation{
                                    history.delete(serving)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $showingAddScrenn, content: MenuView.init)
            .navigationTitle("Morning Brew")
            .toolbar {
                Button{
                    showingAddScrenn = true
                } label: {
                    Label("Add new Drink", systemImage: "plus")
                }
            }
        }
        .environmentObject(menu)
        .environmentObject(history)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
