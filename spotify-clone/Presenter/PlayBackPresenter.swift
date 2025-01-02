//
//  PlayBackPresenter.swift
//  spotify-clone
//
//  Created by Chandru A S on 16/12/24.
//

import Foundation
import UIKit
import AVFoundation


protocol PlayerDataSource: AnyObject {
    var songName: String? { get }
    var subtitle: String? { get }
    var imageURL: URL? { get }
}

final class PlayBackPresenter {
    
    static let shared = PlayBackPresenter()
    
    private var track: AudioTrack?
    
    private var tracks = [AudioTrack]()
    
    var currentTrack: AudioTrack? {
        if let track = track, tracks.isEmpty {
            return track
        } else if !tracks.isEmpty {
           return  tracks.first
        }
        return nil
    }
    
    var player: AVPlayer?
    
    func startPlayBack(from viewController: UIViewController, track: AudioTrack) {
        
        guard let url = URL(string: track.preview_url ?? "") else {
            return
        }
        player = AVPlayer(url: url)
        player?.volume = 0.5
        
        let vc = PlayerViewController()
        vc.dataSource = self
        self.track = track
        self.tracks = []
        viewController.present(UINavigationController(rootViewController: vc) , animated: true) { [weak self] in
            self?.player?.play()
        }
    }
    func startPlayBack(from viewController: UIViewController, tracks: [AudioTrack]) {
        let vc = PlayerViewController()
        self.tracks = tracks
        self.track = nil
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: nil )
    }
    
}

extension PlayBackPresenter: PlayerDataSource {
    var songName: String? {
        return currentTrack?.name
    }
    
    var subtitle: String? {
        return currentTrack?.artists.first?.name
    }
    
    var imageURL: URL? {
        return URL(string: currentTrack?.album?.images.first?.url ?? "")
    }
}
