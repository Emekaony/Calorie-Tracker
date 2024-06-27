//
//  ContentView.swift
//  Calorie Tracker
//
//  Created by SHAdON . on 6/25/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var Meals = MealList()
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(Meals.mealList) { meal in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(meal.calorie) Calories")
                                Text("Food eaten: \(meal.name)")
                            }
                            Spacer()
                            Image(systemName: "trash")
                                .foregroundStyle(.red)
                                .onTapGesture {
                                    Meals.deleteMeal(meal: meal)
                                }
                        }
                    }
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        // make the showAddMealView appear
                        Meals.showAddMealView.toggle()
                        print("the toggled value is now: \(Meals.showAddMealView)")
                    }, label: {
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.black)
                            .bold()
                    })
                }
            })
            .navigationTitle("Calorie Tracker")
            .sheet(isPresented: $Meals.showAddMealView, content: {
                AddMealView(Meals: Meals)
            })
        }
        
    }
}

// struct for individual food
struct Meal: Equatable, Identifiable {
    var id = UUID()
    var calorie: String
    var name: String
}

// source of truth!
class MealList: ObservableObject {
    // the published identifier makes sure that your UI stays
    // in sync with your data model. Learning a lot
    @Published var mealList: [Meal] = []
    @Published var showAddMealView = false
    
    func addMeal(calorie: String, name: String) {
        mealList.append(Meal(calorie: calorie, name: name))
    }
    
    func deleteMeal(meal: Meal) {
        if let idx = mealList.firstIndex(of: meal) {
            mealList.remove(at: idx)
        } else {
            print("Error deleting meal: \(meal)")
        }
    }
}

#Preview {
    ContentView()
}
