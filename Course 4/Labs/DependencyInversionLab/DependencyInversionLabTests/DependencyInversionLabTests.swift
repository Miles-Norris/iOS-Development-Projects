//
//  DependencyInversionLabTests.swift
//  DependencyInversionLabTests
//
//  Created by Miles Norris on 6/8/26.
//

import Testing
import Foundation
@testable import DependencyInversionLab

@MainActor
struct DependencyInversionLabTests {

    @Test func testSongDataFetchSuccess() {
        let data = Song(name: "Pay Phone", artist: "Maroon 5")
        
        let stubNetworkService = StubSongNetworkService(data: data)
        let dataFetcher = DataFetcher(networkService: stubNetworkService)
        var completionData: Song?
        
        dataFetcher.fetchData { data in
            completionData = data
        }
        
        #expect(completionData == data)
    }
    
    @Test func testSongDataFailedToFetch() {
        let fakeSongNetworkService = FakeSongNetwortService()
        let dataFetcher = DataFetcher(networkService: fakeSongNetworkService)
        var completionData: Song?
        
        dataFetcher.fetchData { data in
            completionData = data
        }
        
        #expect(completionData == nil)
    }
    
    @Test func testSongDataFetcherIsCalled() {
        let mockSongNetworkService = MockSongNetworkService()
        let dataFetcher = DataFetcher(networkService: mockSongNetworkService)
        
        dataFetcher.fetchData { _ in }
        
        #expect(mockSongNetworkService.dataFetched)
    }

}
