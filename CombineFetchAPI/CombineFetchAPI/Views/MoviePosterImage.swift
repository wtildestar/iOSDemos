//
//  MoviePosterImage.swift
//  CombineFetchAPI
//
//  Created by wtildestar on 03/02/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import SwiftUI

struct MoviePosterImage: View {
    @ObservedObject var imageLoader: ImageLoader
    @State var isImageLoaded = false
    let posterSize: PosterStyle.Size
    
    var body: some View {
        ZStack{
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                .resizable()
                    .renderingMode(.original)
                    .posterStyle(loaded: true, size: posterSize)
                    .animation(.easeInOut)
                    .onAppear {
                        self.isImageLoaded = true
                }
            } else {
                Rectangle()
                    .foregroundColor(.gray)
                    .posterStyle(loaded: false, size: posterSize)
            }
        }
    }
}
