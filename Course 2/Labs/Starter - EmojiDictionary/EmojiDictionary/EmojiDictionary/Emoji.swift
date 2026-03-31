//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by Jane Madsen on 10/30/25.
//

import Foundation

struct Emoji: Codable, Identifiable {
    var id: UUID = UUID()
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("emoji").appendingPathExtension("plist")
    
    static func saveToFile(emojis: [Emoji]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedEmojis = try? propertyListEncoder.encode(emojis)
        
        try? encodedEmojis?.write(to: archiveURL, options: .noFileProtection)
    }
    static func loadFromFile() -> [Emoji]? {
        let propertyListDecoder = PropertyListDecoder()
        if let emojiData = try? Data(contentsOf: archiveURL),
           let decodedEmojis = try? propertyListDecoder.decode([Emoji].self, from: emojiData) {
            return decodedEmojis
        } else {
            return nil
        }
    }
    static func sampleEmojis() -> [Emoji] {
        [Emoji(symbol: "😀", name: "Grinning Face", description: "A typical smiley face.", usage: "happiness")]
    }
}
