//
//  AddMealView.swift
//  Calorie Tracker
//
//  Created by SHAdON . on 6/25/24.
//

import SwiftUI

struct AddMealView: View {
    
    @ObservedObject var Meals: MealList
    
    @State private var calorie: String = ""
    @State private var food: String = ""
    
    @State private var calorieHintText = "calorie"
    @State private var foodHintText = "food"
    
    var body: some View {
        NavigationStack {
            VStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 300, height: 50)
                    .foregroundStyle(.white)
                    .shadow(color: .gray, radius: 2, x: 0, y: 3)
                    .overlay {
                        TextField(calorieHintText, text: $calorie)
                            .padding()
                            .bold()
                            .autocorrectionDisabled()
                    }
                
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 300, height: 50)
                    .foregroundStyle(.white)
                    .shadow(color: .gray, radius: 2, x: 0, y: 3)
                    .overlay {
                        TextField(foodHintText, text: $food)
                            .padding()
                            .bold()
                            .autocorrectionDisabled()
                    }
                    .padding()
                
                Button(action: {
                    let foodEntryIsEmpty = food.isEmpty
                    let calorieEntryIsEmpty = calorie.isEmpty
                    
                    if foodEntryIsEmpty && calorieEntryIsEmpty {
                        foodHintText = "add food..."
                        calorieHintText = "add calories..."
                    }
                    
                    if food.isEmpty {
                        foodHintText = "add food..."
                    } else if calorie.isEmpty {
                        calorieHintText = "add calories...."
                    } else {
                        Meals.addMeal(calorie: calorie, name: food)
                        Meals.showAddMealView = false
                    }
                }, label: {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 300, height: 50)
                        .foregroundStyle(.blue)
                        .overlay {
                            Text("Add food!")
                                .bold()
                                .font(.title2)
                                .foregroundStyle(.white)
                        }
                })
                Spacer()
            }
            .padding()
            .navigationTitle("Add Meal View 🍱")
        }
    }
}

#Preview {
    // here, just use a regular intialization of the List
    AddMealView(Meals: MealList())
}
