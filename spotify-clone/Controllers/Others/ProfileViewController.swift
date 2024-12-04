//
//  ProfileViewController.swift
//  spotify-clone
//
//  Created by Chandru A S on 04/12/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.register(UITableViewCell.self,
                            forCellReuseIdentifier: "cell")
        return tableView
        
    }()
    
    private var models = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

       title = "Profile"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        fetchProfile()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func fetchProfile() {
        APICaller.shared.getCurrentUserProfile { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.updateUI(with: model)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.failedToFetchProfile()
                    
                }
            }
           
        }
    }
    
    private func updateUI(with model: UserProfile) {
        tableView.isHidden = false
        models.append("FullName: \(model.display_name)")
        models.append ("Email Address: \(model.email)")
        models.append ("UserId: \(model.id)")
        models.append ("Plan: \(model.product)")
        tableView.reloadData()
    }
    
    private func failedToFetchProfile() {
        let label = UILabel(frame: .zero)
        label.text = "Failed to load profile"
        label.textColor = .secondaryLabel
        label.sizeToFit()
        view.addSubview(label)
        label.center = view.center
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   
}

