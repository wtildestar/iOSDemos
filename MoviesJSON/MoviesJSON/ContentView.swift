//
//  ContentView.swift
//  MoviesJSON
//
//  Created by wtildestar on 04/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var moviesViewModel = MoviesViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $moviesViewModel.indexEndpoint){
                    Text("Now").tag(0)
                    Text("Popular").tag(1)
                    Text("Upcoming").tag(2)
                    Text("Top").tag(3)
                }
                .pickerStyle(SegmentedPickerStyle())
                MoviesList(movies: moviesViewModel.movies)
            } // VStack
            .navigationBarTitle("Movies")
        } // NavigationView
    } // body
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
