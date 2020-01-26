//
//  ActivityIndicatorView.swift
//  SwiftUIApp
//
//  Created by wtildestar on 26/01/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import SwiftUI
import UIKit

struct ActivityIndicatorView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        uiView.startAnimating()
    }
    
}
