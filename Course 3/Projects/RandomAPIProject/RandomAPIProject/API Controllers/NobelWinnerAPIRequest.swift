//
//  NobelWinnerAPIRequest.swift
//  RandomAPIProject
//
//  Created by Miles Norris on 4/20/26.
//

import Foundation

struct NobelWinnerAPIRequest: APIRequest {
    var urlRequest: URLRequest
    
    init(year: String) {
        var urlComponents = URLComponents(string: "https://api.nobelprize.org/v1/prize.json")!
        let querys = [
            "year": year
        ]
        urlComponents.queryItems = querys.map { URLQueryItem(name: $0.key, value: $0.value) }
        urlRequest = URLRequest(url: urlComponents.url!)
    }
    
    func decodeResponse(data: Data) throws -> NobelWinner {
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode(NobelWinner.self, from: data)
    }
}

