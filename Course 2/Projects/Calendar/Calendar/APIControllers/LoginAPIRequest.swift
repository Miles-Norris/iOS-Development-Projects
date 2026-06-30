//
//  LoginAPIRequest.swift
//  Calendar
//
//  Created by Miles Norris on 6/21/26.
//

import Foundation

struct LoginBody: Encodable {
    let email: String
    let password: String
}

struct LoginAPIRequest: APIRequest {
    var urlRequest: URLRequest
    
    init(body: LoginBody) throws {
        let urlComponents = URLComponents(string: "https://social-media-app.ryanplitt.com/auth/login")!
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(body)
        
        self.urlRequest = request
    }
    
    func decodeResponse(data: Data) throws -> User {
        let decoder = JSONDecoder()
        
        return try decoder.decode(User.self, from: data)
    }
}
