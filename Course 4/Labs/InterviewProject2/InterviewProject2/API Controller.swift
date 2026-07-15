//
//  API Controller.swift
//  InterviewProject2
//
//  Created by Miles Norris on 7/14/26.
//

import Foundation

enum APIRequestError: LocalizedError {
    case invalidResponse(Int)

    var errorDescription: String? {
        switch self {
        case .invalidResponse(let errorCode):
            return "Invalid Response Received: errorCode \(errorCode)"
        }
    }
}

protocol APIRequest {
    associatedtype Response
    var urlRequest: URLRequest { get }
    func decodeResponse(data: Data) throws -> Response
}

struct DataFetcher {

    func fetchData<Request: APIRequest>(_ request: Request) async throws -> Request.Response {
        let (data, response) = try await URLSession.shared.data(for: request.urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIRequestError.invalidResponse(0)
        }
        guard httpResponse.statusCode == 200 else {
            throw APIRequestError.invalidResponse(httpResponse.statusCode)
        }
        
        return try request.decodeResponse(data: data)
    }
}

enum GenderOptions: String {
    case male, female, both
}

struct RandomPersonAPIRequest: APIRequest {
    var urlRequest: URLRequest
    
    init(resultCount: Int, gender: GenderOptions) {
        var urlComponents = URLComponents(string: "https://randomuser.me/api/")!
        
        var querys: [String: String]
        
        if gender != .both {
            querys = [
                "results": "\(resultCount)",
                "gender": gender.rawValue
            ]
        } else {
            querys = [
                "results": "\(resultCount)"
            ]
        }
        
        urlComponents.queryItems = querys.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        self.urlRequest = URLRequest(url: urlComponents.url!)
    }
    
    func decodeResponse(data: Data) throws -> RandomUserResponse {
        let decoder = JSONDecoder()
        
        return try decoder.decode(RandomUserResponse.self, from: data)
    }
}
