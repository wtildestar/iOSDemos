//
//  VideoLooperView.swift
//  MiniСinema
//
//  Created by Алексей Пархоменко on 11/03/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit
import AVFoundation

class VideoLooperView: UIView {
    let videos: [Video]
    let videoPlayerView = VideoPlayerView()
    
    // @objc для NSKeyValueObservation
    @objc private let queuePlayer = AVQueuePlayer()
    
    // token для наблюдателя
    private var token: NSKeyValueObservation?
    
    
    
    init(videos: [Video]) {
        self.videos = videos
        
        super.init(frame: .zero)
        
        initializePlayer()
        addGestureRecognizers()
    }
    
    override func layoutSubviews() {
        addSubview(videoPlayerView)
        videoPlayerView.frame = bounds
    }
    
    private func initializePlayer() {
        videoPlayerView.player = queuePlayer
        addAllVideosToPlayer()
        
        queuePlayer.volume = 0.0
        queuePlayer.play()
        
        token = queuePlayer.observe(\.currentItem, changeHandler: { (player, _) in
            // проверяю пришел ли player к окончательному видео
            if self.queuePlayer.items().count == 1 {
                self.addAllVideosToPlayer()
            }
        })
    }
    
    func pause() {
        queuePlayer.pause()
    }
    
    func play() {
        queuePlayer.play()
    }
    
    func addGestureRecognizers() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(VideoLooperView.wasTapped))
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(VideoLooperView.wasDoubleTapped))
        
        tap.require(toFail: doubleTap)
        
        addGestureRecognizer(tap)
        addGestureRecognizer(doubleTap)
    }
    
    @objc func wasTapped() {
        queuePlayer.volume = queuePlayer.volume == 1.0 ? 0.0 : 1.0
    }
    
    @objc func wasDoubleTapped() {
        queuePlayer.rate = queuePlayer.rate == 1.0 ? 2.0 : 1.0
    }
    
    private func addAllVideosToPlayer() {
        for video in videos {
            let asset = AVURLAsset(url: video.url)
            
            let item = AVPlayerItem(asset: asset)
            queuePlayer.insert(item, after: queuePlayer.items().last)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
