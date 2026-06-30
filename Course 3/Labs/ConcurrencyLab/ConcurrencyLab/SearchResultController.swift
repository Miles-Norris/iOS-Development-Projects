//
//  SearchResultController.swift
//  ConcurrencyLab
//
//  Created by Miles Norris on 4/15/26.
//

import Foundation

enum MediaSearchError: LocalizedError {
    case itemNotFound
    
    var errorDescription: String? {
        switch self {
        case .itemNotFound:
            "Search Failed"
        }
    }
}

protocol DataFetcher {
    associatedtype DataRespone
    
    func fetchData() async throws -> DataRespone
}

struct MediaSearchController: DataFetcher {
    var querys: [String: String]
    
    func fetchData() async throws -> SearchResult {
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search")!
        
        urlComponents.queryItems = querys.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw MediaSearchError.itemNotFound
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(SearchResult.self, from: data)
    }
}
