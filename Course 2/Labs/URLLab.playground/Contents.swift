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

let querys = [
    "term": "brandon+sanderson",
    "country": "US",
    "limit": "2"
]

let baseURL = "https://itunes.apple.com/search"

var urlComponents = URLComponents(string: baseURL)!

urlComponents.queryItems = querys.map { URLQueryItem(name: $0.key, value: $0.value) }

Task {
    let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
    
    if let httpResponse = response as? HTTPURLResponse,
       httpResponse.statusCode == 200,
       let result = try? JSONDecoder().decode(SearchResult.self, from: data) {
        
        for resultItem in result.results {
            if let longDescription = resultItem.longDescription {
                print(longDescription)
            } else if let description = resultItem.description {
                print(description)
            } else if let shortDescription = resultItem.shortDescription {
                print(shortDescription)
            }
        }
        
    }
}
 
