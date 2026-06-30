//
//  APIService.swift
//  Calendar
//
//  Created by Miles Norris on 6/11/26.
//

import Foundation

enum APIRequestError: LocalizedError {
    case invalidResponse
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid Response Received"
        }
    }
}

protocol APIRequest {
    associatedtype Response
    var urlRequest: URLRequest { get }
    func decodeResponse(data: Data) throws -> Response
}

protocol APIService {
    func fetchData<Request: APIRequest>(_ request: Request) async throws -> Request.Response
}

struct DataFetcher: APIService {
    static let shared = DataFetcher()
    
    func fetchData<Request: APIRequest>(_ request: Request) async throws -> Request.Response {
        let (data, response) = try await URLSession.shared.data(for: request.urlRequest)

        guard let httpResponse = response as? HTTPURLResponse,
           httpResponse.statusCode == 200 else {
            throw APIRequestError.invalidResponse
        }
        
        return try request.decodeResponse(data: data)
    }
}


