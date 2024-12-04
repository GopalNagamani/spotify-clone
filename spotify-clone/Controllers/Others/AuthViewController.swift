//
//  AuthViewController.swift
//  spotify-clone
//
//  Created by Chandru A S on 04/12/24.
//

import UIKit
import WebKit
import SafariServices

class AuthViewController: UIViewController, SFSafariViewControllerDelegate {
    
    
    var safariVC: SFSafariViewController?

    
    public var completionHandler: ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        view.backgroundColor = .systemBackground
        presentLogin()
        
    }
    
    func presentLogin() {
        guard let url = AuthManager.shared.signInURL else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        self.safariVC = safariVC
        safariVC.delegate = self
        present(safariVC, animated: true)
    }
}
