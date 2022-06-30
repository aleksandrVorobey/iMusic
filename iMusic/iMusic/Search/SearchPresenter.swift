//
//  SearchPresenter.swift
//  iMusic
//
//  Created by admin on 30.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchPresentationLogic {
    func presentData(response: Search.Model.Response.ResponseType)
}

class SearchPresenter: SearchPresentationLogic {
    weak var viewController: SearchDisplayLogic?
    
    func presentData(response: Search.Model.Response.ResponseType) {
        
        switch response {
        case .some:
            print("presenter some")
        case .presentTracks(let searchResult):
            print("presenter tracks")
            let cells = searchResult?.results.map({ track in
                cellViewModel(from: track)
            }) ?? []
            let searchViewModel = SearchViewModel.init(cells: cells)
            viewController?.displayData(viewModel: Search.Model.ViewModel.ViewModelData.displayTracks(searchViewModel: searchViewModel))
        }
    }
    
    private func cellViewModel(from track: Track) -> SearchViewModel.Cell {
        
        return SearchViewModel.Cell(iconURLString: track.artworkUrl100,
                                    trackName: track.trackName ?? "",
                                    collectionName: track.collectionName ?? "",
                                    artistName: track.artistName ?? "")
    }
    
}
