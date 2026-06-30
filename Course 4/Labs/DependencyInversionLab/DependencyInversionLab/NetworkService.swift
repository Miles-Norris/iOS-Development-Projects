//
//  NetworkService.swift
//  DependencyInversionLab
//
//  Created by Miles Norris on 6/8/26.
//

import Foundation

protocol SongNetworkService {
    func fetchData(completion: (Song?) -> Void)
}

class DataFetcher {
    let networkService: SongNetworkService
    
    init(networkService: SongNetworkService) {
        self.networkService = networkService
    }
    
    func fetchData(completion: (Song?) -> Void) {
        networkService.fetchData { data in
            completion(data)
        }
    }
}

class StubSongNetworkService: SongNetworkService {
    var data: Song
    
    init(data: Song) {
        self.data = data
    }
    
    func fetchData(completion: (Song?) -> Void) {
        completion(data)
    }
}

class FakeSongNetwortService: SongNetworkService {
    func fetchData(completion: (Song?) -> Void) {
        completion(nil)
    }
}

class MockSongNetworkService: SongNetworkService {
    var dataFetched = false
    
    func fetchData(completion: (Song?) -> Void) {
        dataFetched = true
    }
}
