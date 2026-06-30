//
//  AssignmentAPIRequest.swift
//  Calendar
//
//  Created by Miles Norris on 6/11/26.
//

import Foundation

struct AssignmentAPIRequest: APIRequest {
    typealias Response = Any

    var urlRequest: URLRequest
    
    let returnsArray: Bool

    init(endpoint: String, isReturningArray: Bool, secret: UUID) {
        var urlComponents = URLComponents(string: "https://social-media-app.ryanplitt.com")!
        
        urlComponents.path += endpoint
        
        var querys: [String: String] = [:]
        
        if isReturningArray {
            querys = [
                "includeProgress": "true",
                "includeFAQs": "true",
                "cohort": "winter2026"
            ]
        } else {
            querys = [
                "includeProgress": "true",
                "includeFAQs": "true"
            ]
        }
        
        urlComponents.queryItems = querys.map { URLQueryItem(name: $0.key, value: $0.value) }
    
        self.returnsArray = isReturningArray
        
        self.urlRequest = URLRequest(url: urlComponents.url!)
        self.urlRequest.setValue("Bearer \(secret)", forHTTPHeaderField: "Authorization")
    }

    func decodeResponse(data: Data) throws -> Any {
        let decoder = JSONDecoder()
        
        if returnsArray {
            return try decoder.decode([Assignment].self, from: data)
        } else {
            return try decoder.decode(Assignment.self, from: data)
        }
    }
}
