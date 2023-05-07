//
//  Service.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 28.04.2023.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    func fetchApps(searchTerm: String, completion: @escaping (SearchResult?, Error?) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm))&entity=software"
        
        fetchGenericJSONData(urlString: urlString, completion: completion)
        
//        guard let url = URL(string: urlString) else {return}
//        URLSession.shared.dataTask(with: url) { data, response , error in
//            
//            if let error = error {
//                print("ERROR : \(error)")
//                completion([], nil)
//                return
//            }
//            
//            //            print(data)
//            //            print(String(data: data!, encoding: .utf8))
//            
//            guard let data = data else {return}
//            do {
//                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
//                completion(searchResult.results, nil)
//                
//                //                print(searchResult.results)
//                //                searchResult.results.forEach {(print($0.trackName, "|", $0.primaryGenreName))}
//            } catch {
//                print("ERROR: \(error)")
//                completion([], error)
//            }
//        }.resume()
    }
    
    func fetchAppGroups(urlString: String, completion: @escaping (AppGroup?, Error?) -> Void) {
        
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchTopFreeApps(completion: @escaping (AppGroup?, Error?) -> ()) {
        let url = "https://rss.applemarketingtools.com/api/v2/tr/apps/top-free/50/apps.json"
        fetchAppGroups(urlString: url, completion: completion)
    }
    
    func fetchTopMusicAlbums(completion: @escaping (AppGroup?, Error?) -> ()) {
        let url = "https://rss.applemarketingtools.com/api/v2/tr/music/most-played/50/albums.json"
        fetchAppGroups(urlString: url, completion: completion)
    }
    
    func fetchTopPodcasts(completion: @escaping (AppGroup?, Error?) -> ()) {
        let url = "https://rss.applemarketingtools.com/api/v2/us/podcasts/top/50/podcasts.json"
        fetchAppGroups(urlString: url, completion: completion)
    }
    
    func fetchHeaderItems(completion: @escaping ([HeaderResult]?, Error?) -> ()) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping(T?, Error?) -> ()) {
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data, response , error in
            
            if let error = error {
                print("ERROR : \(error)")
                completion(nil, error)
                return
            }
            
            //            print(data)
            //            print(String(data: data!, encoding: .utf8))
            
            guard let data = data else {return}
            do {
                let objects = try JSONDecoder().decode(T.self, from: data)
                completion(objects, nil)
            } catch {
                print("ERROR: \(error)")
                completion(nil, error)
            }
        }.resume()
    }
}
