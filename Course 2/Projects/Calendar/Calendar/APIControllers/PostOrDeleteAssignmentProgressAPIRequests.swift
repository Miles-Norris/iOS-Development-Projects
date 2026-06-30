//
//  Post:DeleteAssignmentProgressAPIRequests.swift
//  Calendar
//
//  Created by Miles Norris on 6/11/26.
//

import Foundation

struct AssignmentProgressPostBody: Encodable {
    let assignmentID: UUID
    let progress: String
}

struct AssignmentProgressDeleteBody: Encodable {
    let assignmentID: UUID
}

struct UpdateAssignmentProgressAPIRequest: APIRequest {
    var urlRequest: URLRequest
    
    init(secret: UUID, body: AssignmentProgressPostBody) throws {
        let urlComponents = URLComponents(string: "https://social-media-app.ryanplitt.com/assignment/progress")!
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "POST"
        request.setValue("Bearer \(secret)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(body)
        
        self.urlRequest = request
    }
    
    func decodeResponse(data: Data) throws -> Assignment {
        let decoder = JSONDecoder()
        
        return try decoder.decode(Assignment.self, from: data)
    }
}

struct DeleteAssignmentProgressAPIRequest: APIRequest {
    var urlRequest: URLRequest
    
    init(secret: UUID, body: AssignmentProgressPostBody) throws {
        let urlComponents = URLComponents(string: "https://social-media-app.ryanplitt.com/assignment/progress")!
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "DELETE"
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
