//
//  ContentView.swift
//  SwiftUIApp
//
//  Created by wtildestar on 25/01/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import SwiftUI
import Combine

// MARK: - Views

struct RootView: View {
    
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            FoodListView()
                .tabItem {
                    VStack {
                        Image(systemName: "suit.heart")
                        Text("Food")
                    }
            }
        .environmentObject(FoodListViewModel())
            .tag(0)
            StartView()
                .tabItem {
                    VStack {
                        Image(systemName: "bolt")
                        Text("Start")
                    }
            }
            .tag(1)
            AboutView()
                .tabItem {
                    VStack {
                        Image(systemName: "star")
                        Text("About")
                    }
            }
            .tag(2)
        }
    }
    
}

// MARK: - Views

struct StartView: View {
    var body: some View {
        Text("Start Page")
    }
}

struct AboutView: View {
    @State private var showAuthors: Bool = false
    
    var body: some View {
        Button(action: {
            self.showAuthors = true
        }) {
            Text("About Page")
        }.betterSheet(isPresented: self.$showAuthors, onDismiss: { print("dismiss") }) {
            AboutAuthorsModal()
        }
        
    }
}

struct AboutAuthorsModal: View {
    var body: some View {
        Text("🐼")
            .font(.largeTitle)
    }
}
