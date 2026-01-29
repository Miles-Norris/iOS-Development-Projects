import UIKit

struct Song: Equatable {
    var id: String = UUID().uuidString
    var songName: String
    var artistName: String
    var durationInSeconds: Int
    
    func play() {
        print("\"\(songName)\" by \(artistName) is currently playing.")
    }
    static func == (lhs: Song, rhs: Song) -> Bool {
        return lhs.id == rhs.id
    }
}

class Playlist {
    var name: String
    var author: String
    var songs: [Song]
    var currentlyPlaying = false
    var songPlaying: Song?
    var currentSongIndex = 0
    
    init(name: String, author: String, songs: [Song]) {
        self.name = name
        self.author = author
        self.songs = songs
    }
    
    // Core mutation
    func add(_ song: Song) {
        songs.append(song)
    }
    func remove(at index: Int) {
        songs.remove(at: index)
    }
    func clear() {
        songs.removeAll()
    }
    // Querying / reading
    var count: Int {
        songs.count
    }
    func allSongs() -> [Song] {
        return songs
    }
    func totalDuration() -> Int {
        var total = 0
        for song in songs {
            total += song.durationInSeconds
        }
        return total
    }
    func currentSong() -> Song? {
        if currentlyPlaying {
            return songPlaying
        } else {
            return nil
        }
    }
    // Playback navigation
    func play(at index: Int) {
        if songs.count - 1 >= index {
            let chosenSong = songs[index]
            currentlyPlaying = true
            songPlaying = chosenSong
            currentSongIndex = index
            chosenSong.play()
        }
    }
    func playNext() {
        if currentSongIndex < (songs.count - 1) {
            let newSong = songs[currentSongIndex + 1]
            currentlyPlaying = true
            songPlaying = newSong
            currentSongIndex += 1
            newSong.play()
        }
    }
    func playPrevious() {
        if currentSongIndex > 0 {
            let newSong = songs[currentSongIndex - 1]
            currentlyPlaying = true
            songPlaying = newSong
            currentSongIndex -= 1
            newSong.play()
        }
    }
    func pause() {
        if currentlyPlaying {
            currentlyPlaying = false
            print("\(songPlaying!.songName) has stopped playing.")
        }
    }
    func unpause() {
        if !currentlyPlaying {
            if let currentSong = songPlaying {
                currentlyPlaying = true
                currentSong.play()
            }
        }
    }
    // Shuffle
    func shuffle() {
        songs.shuffle()
        currentlyPlaying = true
        currentSongIndex = 0
        songPlaying = songs[0]
        songPlaying?.play()
    }
    // Sorting/Rearranging functions
    func sortByDuration() {
        var songsSortedByDuration: [Song] {
            songs.sorted(by: { $0.durationInSeconds < $1.durationInSeconds })
        }
        songs = songsSortedByDuration
    }
    func sortBySongName() {
        var songsSortedByName: [Song] {
            songs.sorted(by: { $0.songName < $1.songName })
        }
        songs = songsSortedByName
    }
    func sortByArtistName() {
        var songsSortedByArtistName: [Song] {
            songs.sorted(by: { $0.artistName < $1.artistName })
        }
        songs = songsSortedByArtistName
    }
    func move(song: Song, to index: Int) {
        if let songToMoveIndex = songs.firstIndex(of: song) {
            songs.remove(at: songToMoveIndex)
        }
        songs.insert(song, at: index)
    }
}

let dreamLantern = Song(songName: "Dream Lantern", artistName: "RADWIMPS", durationInSeconds: 132)
let sparkle = Song(songName: "Sparkle", artistName: "RADWIMPS", durationInSeconds: 538)
let zenzenzense = Song(songName: "Zenzenzense", artistName: "RADWIMPS", durationInSeconds: 286)
let nandemonaiya = Song(songName: "Nandemonaiya", artistName: "RADWIMPS", durationInSeconds: 343)
let kanataHaluka = Song(songName: "Kanata Haluka", artistName: "RADWIMPS", durationInSeconds: 356)
let soundOfSnow = Song(songName: "Sound Of Snow", artistName: "Novelbright", durationInSeconds: 228)
let aitokaKoitoka = Song(songName: "Aitoka Koitoka", artistName: "Novelbright", durationInSeconds: 232)
let lemon = Song(songName: "Lemon", artistName: "Kenshi Yonezu", durationInSeconds: 256)
let unmei = Song(songName: "Unmei", artistName: "Tani Yuuki", durationInSeconds: 253)
let beautiful = Song(songName: "Beautiful", artistName: "HIRAIDAI", durationInSeconds: 233)

var playlist1 = Playlist(name: "My Playlist1", author: "Miles Norris", songs: [dreamLantern, sparkle, zenzenzense, nandemonaiya, kanataHaluka])
var playlist2 = Playlist(name: "My Playlist2", author: "Miles Norris", songs: [soundOfSnow, aitokaKoitoka, lemon, unmei, beautiful])
var allPlaylists: [Playlist] = []

addPlaylist(playlist1)
addPlaylist(playlist2)

print(playlist1.songs)

playlist1.sortByDuration()

print(playlist1.songs)

playlist1.sortBySongName()

print(playlist1.songs)

playlist1.sortByArtistName()

print(playlist1.songs)

print(playlist1.totalDuration())

@MainActor func addPlaylist(_ newPlaylist: Playlist) {
    allPlaylists.append(newPlaylist)
}
