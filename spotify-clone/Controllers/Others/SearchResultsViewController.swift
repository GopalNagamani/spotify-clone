//
//  SearchResultsViewController.swift
//  spotify-clone
//
//  Created by Chandru A S on 04/12/24.
//

import UIKit

struct SearchSection {
    let title: String
    let results : [SearchResult]
}

protocol SearchResultsViewControllerDelegate: AnyObject {
    func didTapResult(_ result: SearchResult)
}



class SearchResultsViewController: UIViewController {
    
    private var sections: [SearchSection] = []
    
    weak var delegate: SearchResultsViewControllerDelegate?
    
    private let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isHidden = true
        return tableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    public func update(with results: [SearchResult]) {
        let albums = results.filter({
            switch $0 {
            case .albums: return true
            default: return false
            }
        })
        let artists = results.filter({
            switch $0 {
            case .artists: return true
            default: return false
            }
        })
        let playlists = results.filter({
            switch $0 {
           
            case .playlists: return true
            default: return false
            }
        })
        let tracks = results.filter({
            switch $0 {
           
            case .tracks: return true
            default: return false
            }
        })
        
        
        
        
        
        self.sections = [
            SearchSection(title: "Songs", results: tracks),
            SearchSection(title: "Artists", results: artists),
            SearchSection(title: "Playlists", results: playlists),
            SearchSection(title: "Albums", results: albums)
           
            
        ]
        self.tableView.isHidden = results.isEmpty
        self.tableView.reloadData()
    }
}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].results.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let result = sections[indexPath.section].results[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch result {
        case .albums(let album):
            cell.textLabel?.text = "Album \(album.name)"
        case .artists(let artist):
            cell.textLabel?.text = "Artist \(artist.name)"
        case .playlists(let playlist):
            cell.textLabel?.text = "Playlist \(playlist.name)"
        case .tracks(let track):
            cell.textLabel?.text = "Track \(track.name)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let result = sections[indexPath.section].results[indexPath.row]
       
       
        delegate?.didTapResult(result)
        
    }
    
    
}
