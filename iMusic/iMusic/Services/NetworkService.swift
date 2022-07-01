//
//  NetworkService.swift
//  iMusic
//
//  Created by admin on 30.06.2022.
//

import Foundation
import Alamofire

class NetworkService {
    func fetshTracks(searchText: String, completion: @escaping (SearchResponse?) -> ()) {
        let url = "https://itunes.apple.com/search"
        let parameters = ["term": "\(searchText)", "limit": "20", "media": "music"]
        
        AF.request(url, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default).responseData { dataResponse in
            if let error = dataResponse.error {
                print("Error received data: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = dataResponse.data else { return }
            let decoder = JSONDecoder()
            
            do {
                let objects = try decoder.decode(SearchResponse.self, from: data)
                print("objects = \(objects)")
                completion(objects)
            } catch let jsonError {
                print("Failed to decode JSON", jsonError)
                completion(nil)
            }
            
        }
    }
}
