//
//  PlayerViewController.swift
//  spotify-clone
//
//  Created by Chandru A S on 04/12/24.
//

import UIKit
import SDWebImage

class PlayerViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        return imageView
        
    }()
    
    weak var dataSource: PlayerDataSource?
    
    private let controlsView = PlayerControlsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(controlsView)
        controlsView.delegate = self
        configureBarButtons()
        
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.width)
        controlsView.frame = CGRect(x: 0, y: imageView.bottom+10, width: view.width-20, height: view.height - imageView.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 15)
        
    }
    
    private func configureBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapAction))
        
    }
    
    private func configure() {
        imageView.sd_setImage(with: dataSource?.imageURL)
        controlsView.configure(with: PlayerControlsViewViewModel(title: dataSource?.songName, subtitle: dataSource?.subtitle))
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true)
    }
    
    @objc private func didTapAction () {
        dismiss(animated: true)
    }
}

extension PlayerViewController: PlayerControlsViewDelegate {
    func playerControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView) {
        //
    }
    
    func playerControlsViewDidTapNextButton(_ playerControlsView: PlayerControlsView) {
        //
    }
    
    func playerControlsViewDidTapBackButton(_ playerControlsView: PlayerControlsView) {
        //
    }
}
