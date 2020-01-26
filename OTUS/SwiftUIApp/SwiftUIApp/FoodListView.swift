//
//  FoodListView.swift
//  SwiftUIApp
//
//  Created by wtildestar on 25/01/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import SwiftUI

struct Food: Identifiable {
    let id = UUID()
    let name: String
    let isFav: Bool
}

struct FoodListView: View {
    @EnvironmentObject var viewModel: FoodListViewModel
    
    @State var favesShowed: Bool = false
    
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ActivityIndicatorView()
                } else {
                    List {
                        FilterView(favesShowed: $favesShowed).environmentObject(viewModel)
                        ForEach(viewModel.foods) { food in
                            if !self.favesShowed || food.isFav {
                                NavigationLink(destination: FoodView()) {
                                    Text(food.name)
                                }
                            }
                        } // ForEach
                    }
                }
            } // Group
                .navigationBarHidden(false)
                .navigationBarTitle("Foods")
        }
        
    }
}

// MARK: - Components

struct FilterView: View {
    @Binding var favesShowed: Bool
    
    @EnvironmentObject var viewModel: FoodListViewModel
    
    var body: some View {
        Toggle(isOn: $favesShowed) {
            Text("Hello world")
        }
    }
}

