//
//  WelcomeViewController.swift
//  spotify-clone
//
//  Created by Chandru A S on 04/12/24.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign In with Spotify", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
       title = "Spotify"
        view.backgroundColor = .green
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = CGRect(x: 20,y: view.height - 50 - view.safeAreaInsets.bottom, width: view.width - 40, height: 50)
    }

    
    @objc func didTapSignIn() {
        let vc = AuthViewController()
        
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
   
    
    public func handleSignIn(success: Bool) {
        // Log user or throw error
        guard success else {
            let alert = UIAlertController(title: "Oops", message: "something went wrong while sing in.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        
        let tabVC = TabBarViewController()
        tabVC.modalPresentationStyle = .fullScreen
        present(tabVC, animated: true)
    }
}
