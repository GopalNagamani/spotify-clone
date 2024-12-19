//
//  PlayBackPresenter.swift
//  spotify-clone
//
//  Created by Chandru A S on 16/12/24.
//

import Foundation
import UIKit

final class PlayBackPresenter {
    static func startPlayBack(from viewController: UIViewController, track: AudioTrack) {
        let vc = PlayerViewController()
        viewController.present(UINavigationController(rootViewController: vc) , animated: true, completion: nil )
    }
    static func startPlayBack(from viewController: UIViewController, tracks: [AudioTrack]) {
        let vc = PlayerViewController()
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: nil )
    }
    
}
