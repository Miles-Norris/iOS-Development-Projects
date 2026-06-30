//
//  DogAPIController.swift
//  RandomAPIProject
//
//  Created by Miles Norris on 4/20/26.
//

import Foundation

struct DogAPIRequest: APIRequest {
    var urlRequest: URLRequest {
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        return URLRequest(url: url)
    }
    
    func decodeResponse(data: Data) throws -> Dog {
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode(Dog.self, from: data)
    }
}
