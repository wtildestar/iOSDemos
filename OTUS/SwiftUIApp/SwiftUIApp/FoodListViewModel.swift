//
//  FoodListViewModel.swift
//  SwiftUIApp
//
//  Created by wtildestar on 26/01/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import SwiftUI

final class FoodListViewModel: ObservableObject {
    @Published private(set) var filterButtonName = "Switch Faves"
    
    @Published private(set) var foods = [Food]()
    
    @Published private(set) var isLoading = false
    
    init() {
        loadFromServer()
    }
    
    func loadFromServer() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.foods = [  Food(name: "Strawberry", isFav: true),
                            Food(name: "Cheese", isFav: false),
                            Food(name: "Apple", isFav: false)]
            self.isLoading = false
        }
    }
}
