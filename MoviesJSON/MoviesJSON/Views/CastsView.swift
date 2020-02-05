//
//  CastsView.swift
//  MoviesJSON
//
//  Created by wtildestar on 05/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import SwiftUI

struct CastsList: View {
    @ObservedObject var castsViewModel: CastViewModel
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack (spacing: 15){
                ForEach (castsViewModel.casts) { cast in
                    VStack{
                        MoviePosterImage(imageLoader:
                            ImageLoaderCache.shared.loaderFor (cast: cast),posterSize: .cast)
                        
                        Text("\(cast.character)").font(.footnote)
                        Text("\(cast.name)")
                    } //VStack
                } // ForEach
            } // lHStack
                .frame(height: 200)
                .padding(10)
        } // ScrollView
    } // body
}

struct CastsView_Previews: PreviewProvider {
    static var previews: some View {
        CastsList(castsViewModel: CastViewModel(movieId: 611914))
    }
}
