//
//  USRepAPIRequest.swift
//  RandomAPIProject
//
//  Created by Miles Norris on 4/20/26.
//

import Foundation

struct USRepAPIRequest: APIRequest {
    var urlRequest: URLRequest
    
    init(zip: String) {
        var urlComponents = URLComponents(string: "https://whoismyrepresentative.com/getall_mems.php")!
        let querys = [
            "zip": zip,
            "output": "json"
        ]
        urlComponents.queryItems = querys.map { URLQueryItem(name: $0.key, value: $0.value) }
        urlRequest = URLRequest(url: urlComponents.url!)
    }
    
    func decodeResponse(data: Data) throws -> USRepResponse {
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode(USRepResponse.self, from: data)
    }
}
