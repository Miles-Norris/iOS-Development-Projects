//
//  SearchResult.swift
//  ConcurrencyLab
//
//  Created by Miles Norris on 4/15/26.
//

import Foundation

struct SearchResult: Codable {
    let resultCount: Int
    let results: [MediaItem]
    
    struct MediaItem: Codable {
        let wrapperType: String
        let kind: String?

        let trackId: Int?
        let artistId: Int?
        let collectionId: Int?

        let artistName: String?
        let trackName: String?
        let collectionName: String?
      
        let trackViewUrl: String?
        let collectionViewUrl: String?
        let artistViewUrl: String?
        let previewUrl: String?
 
        let artworkUrl30: String?
        let artworkUrl60: String?
        let artworkUrl100: String?
   
        let collectionPrice: Double?
        let trackPrice: Double?
        let trackRentalPrice: Double?
        let collectionHdPrice: Double?
        let trackHdPrice: Double?
        let trackHdRentalPrice: Double?
    
        let releaseDate: String?
        let country: String?
        let currency: String?
        let primaryGenreName: String?
   
        let trackTimeMillis: Int?
        let trackCount: Int?

        let shortDescription: String?
        let longDescription: String?
        let description: String?
 
        let collectionExplicitness: String?
        let trackExplicitness: String?
        let contentAdvisoryRating: String?
    
        let copyright: String?
    }
}
