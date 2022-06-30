//
//  SearchTableViewController.swift
//  iMusic
//
//  Created by admin on 30.06.2022.
//

import UIKit
import Alamofire

class SearchMusicViewController: UITableViewController {
    
    private var timer: Timer?
    var networkService = NetworkService()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var tracks = [Track]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchBar()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let track = tracks[indexPath.row]
        cell.textLabel?.text = track.trackName
        cell.textLabel?.numberOfLines = 2
        return cell
    }
    
}

extension SearchMusicViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.networkService.fetshTracks(searchText: searchText) { [weak self] searchResults in
                self?.tracks = searchResults?.results ?? []
                self?.tableView.reloadData()
            }
        })
        
    }
}
