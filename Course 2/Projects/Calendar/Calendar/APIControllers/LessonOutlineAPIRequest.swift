//
//  LessonOutlineAPIRequest.swift
//  Calendar
//
//  Created by Miles Norris on 6/11/26.
//

import Foundation

struct LessonOutlineAPIRequest: APIRequest {
    var urlRequest: URLRequest
    
    init(id: UUID, secret: UUID) {
        var urlComponents = URLComponents(string: "https://social-media-app.ryanplitt.com/lesson")!
        urlComponents.path += "/\(id)"
        
        self.urlRequest = URLRequest(url: urlComponents.url!)
        self.urlRequest.setValue("Bearer \(secret)", forHTTPHeaderField: "Authorization")
    }
    
    func decodeResponse(data: Data) throws -> LessonOutline {
        let decoder = JSONDecoder()
        
        return try decoder.decode(LessonOutline.self, from: data)
    }
}


