import SwiftUI

struct SeriesItem: Codable, Identifiable {
    let Index: Int
    let Title: String
    let Url: String
    var id: Int { Index }
}

struct Episode: Codable, Identifiable {
    let id = UUID()
    let episode: Int
    let streams: [Stream]
}

struct Stream: Codable {
    let stream_url: String
    let quality: Int
}
