//
//  Service.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 28.04.2023.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    func fetchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm))&entity=software"
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
//                searchResult.results.forEach {(print($0.trackName, "|", $0.primaryGenreName))}
            } catch {
                print("ERROR: \(error)")
                completion([], error)
            }
        }.resume()
    }
    
    
    func fetchPopularFreeApps(completion: @escaping (AppGroup?, Error?) -> ()) {
        
        guard let url = URL(string: "https://rss.applemarketingtools.com/api/v2/tr/apps/top-free/50/apps.json") else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(nil, error)
                print("ERROR: \(error)")
            }
            guard let data = data else {return}
//            print(data)
//            print(String(data: data!, encoding: .utf8))
            
            do {
              let appGroup = try JSONDecoder().decode(AppGroup.self, from: data)
//                print(appGroup.feed.results)
//                appGroup.feed.results.forEach {print($0.name)}
                completion(appGroup, nil)

            } catch {
                print("ERROR : \(error)")
                completion(nil, error)
            }
            
        }.resume()
    }
}
