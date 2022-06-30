//
//  SearchModels.swift
//  iMusic
//
//  Created by admin on 30.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Search {
    
    enum Model {
        struct Request {
            enum RequestType {
                case some
                case getTracks(serchTerm: String)
            }
        }
        struct Response {
            enum ResponseType {
                case some
                case presentTracks(searchResponse: SearchResponse?)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case some
                case displayTracks(searchViewModel: SearchViewModel)
            }
        }
    }
    
}

struct SearchViewModel {
    struct Cell {
        var iconURLString: String?
        var trackName: String
        var collectionName: String
        var artistName: String
    }
    
    let cells: [Cell]
}
