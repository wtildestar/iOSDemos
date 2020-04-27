//
//  Article.swift
//  RxNewsApp
//
//  Created by wtildestar on 14/03/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import Foundation

struct ArticlesList: Decodable {
    let articles: [Article]
}

extension ArticlesList {
  
  static var all: Resource<ArticlesList> = {
    let url = URL(string: "https://newsapi.org/v2/top-headlines?country=ru&apiKey=b045a62bc41d4851b74b1da3867e17c2")!
    return Resource(url: url)
  }()
  
}

struct Article: Decodable {
    let title: String
    let description: String
}

