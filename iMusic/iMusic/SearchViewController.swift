//
//  SearchTableViewController.swift
//  iMusic
//
//  Created by admin on 30.06.2022.
//

import UIKit

class SearchViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let tracks = [
    TrackModel(trackName: "AWER", artistName: "sdt"),
    TrackModel(trackName: "CVFR", artistName: "vlop")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchBar()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
//        tableView.delegate = self
//        tableView.dataSource = self
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

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
