//
//  StreamViewController.swift
//  buffup-ios
//
//  Created by Eleftherios Charitou on 14/01/2020.
//  Copyright © 2020 BuffUp. All rights reserved.
//

import UIKit
import AVFoundation
import BuffSDK

class StreamViewController: LandscapeViewController {
    
    @IBOutlet weak var exitButton: UIButton!
    
    private var player: AVPlayer!
    private var timeObserver: Any?
    
    lazy var playerLayer: AVPlayerLayer = {
        let layer = AVPlayerLayer(player: player)
        layer.frame = self.view.bounds
        layer.videoGravity = .resizeAspectFill
        layer.needsDisplayOnBoundsChange = true
        return layer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showExitButton(recognizer:)))
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let urlString = "https://hls-test.buffup.net/ataFootball/main.m3u8"
        if let videoURL = URL(string: urlString) {
            self.playVideoWithURL(url: videoURL)
        }
    }
    
    deinit {
        cleanPlayer()
    }
      
    private func playVideoWithURL(url: URL) {
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: playerItem)
        self.view.layer.addSublayer(playerLayer)
        player.allowsExternalPlayback = false
        #if DEBUG
            player.isMuted = true
        #endif
        player.play()
    }
    
    @objc
    private func showExitButton(recognizer: UIGestureRecognizer) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        exitButton.isHidden = false
        self.view.bringSubviewToFront(exitButton)
        UIView.animate(withDuration: 0.3) {
            self.exitButton.alpha = 1
        }
        self.perform(#selector(hideExitButton), with: nil, afterDelay: 2)
    }
    
    @objc
    private func hideExitButton() {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        exitButton.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.exitButton.alpha = 0
        }) { _ in
            self.exitButton.isHidden = true
        }
        self.perform(#selector(hideExitButton), with: nil, afterDelay: 3)
    }

    @IBAction func exitStream(_ sender: Any) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        self.dismiss(animated: true, completion: nil)
    }
    
    private func cleanPlayer() {
        guard player != nil else { return }
        player.pause()
    }
}

extension StreamViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let touchView = touch.view, touchView.classForCoder != gestureRecognizer.view?.classForCoder  {
            return false
        }
        return true
    }
}
