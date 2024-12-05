//
//  ViewController.swift
//  spotify-clone
//
//  Created by Chandru A S on 04/12/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
        fetchData()
    }
    
    private func fetchData() {
        APICaller.shared.getNewRelease { result in
            switch result {
            case .failure(let error):
                break
            case .success(let model):
                print(model)
                break
            }
        }
    }
    
    
    @objc func didTapSettings() {
        let vc = SettingsViewController()
        vc.title = "Settings"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
         
}
