//
//  Video.swift
//  MiniСinema
//
//  Created by Алексей Пархоменко on 11/03/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import Foundation
import UIKit

struct Video {
    let url: URL
    let filmImage: UIImage
    let title: String
    
    static func localVideos() -> [Video] {
        var videos: [Video] = []
        
        let titles = ["Богемская рапсодия","Зеленая книга","Кристофер Робин","Семья по-быстрому"]
        let movieNames = ["Cat","Hamsters","Sea","Someone"]
        
        for (index, name) in movieNames.enumerated() {
            let urlPath = Bundle.main.path(forResource: name, ofType: "mp4")!
            let url = URL(fileURLWithPath: urlPath)
            let video = Video(url: url, filmImage: UIImage(named: titles[index])!, title: titles[index])
            videos.append(video)
        }
        return videos
    }
    
    static func allVideos() -> [Video] {
        var videos = localVideos()
        let videoURLString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        
        // Add one remote video
        if let url = URL(string: videoURLString) {
            let remoteVideo = Video(url: url, filmImage: UIImage(named: "Зеленая книга")!, title: "Зеленая книга Часть 2")
            videos.append(remoteVideo)
        }
        
        return videos
    }
}


