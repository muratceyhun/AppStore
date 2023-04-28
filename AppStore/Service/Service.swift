//
//  Service.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 28.04.2023.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    func fetchApps(completion: @escaping ([Result], Error?) -> ()) {
        print("555555")
        let urlString = "https://itunes.apple.com/search?term=instagram&entity=software"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data, response , error in

            if let error = error {
                print("ERROR : \(error)")
                completion([], nil)
                return
            }

            //            print(data)
            //            print(String(data: data!, encoding: .utf8))

            guard let data = data else {return}
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(searchResult.results, nil)

//                print(searchResult.results)
                searchResult.results.forEach {(print($0.trackName, "|", $0.primaryGenreName))}
            } catch {
                print("ERROR: \(error)")
                completion([], error)
            }
        }.resume()
    }
}
