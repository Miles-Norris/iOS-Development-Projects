//
//  LessonFeedbackAPIRequest.swift
//  Calendar
//
//  Created by Miles Norris on 6/11/26.
//


import Foundation

struct LessonFeedbackBody: Encodable {
    let lessonID: UUID
    let feedback: String
}

struct VoidRepsonse {}

struct LessonFeedbackAPIRequest: APIRequest {
    var urlRequest: URLRequest
    
    init(secret: UUID, body: LessonFeedbackBody) throws {
        let urlComponents = URLComponents(string: "https://social-media-app.ryanplitt.com/lesson/feedback")!
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "POST"
        request.setValue("Bearer \(secret)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(body)
        
        self.urlRequest = request
    }
    
    func decodeResponse(data: Data) throws -> VoidRepsonse {
        VoidRepsonse()
    }
}

