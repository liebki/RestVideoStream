import SwiftUI

struct EpisodeListView: View {
    let seriesTitle: String
    let seriesName: String
    let streamIndex: Int
    @State private var episodes: [Episode] = []

    public var baseRestServerAddress: String = "http://12.34.56.789:8762"
    
    var body: some View {
            VStack {
                List(episodes) { episode in
                    ForEach(episode.streams, id: \.stream_url) { stream in
                        NavigationLink(destination: VideoPlayerView(videoURL: stream.stream_url)) {
                            Text("Episode Nr.\(episode.episode)  |  Q: \(stream.quality)").padding()
                        }
                    }
                }
                .onAppear {
                    fetchEpisodes()
                }
            }
            .navigationTitle("\(seriesTitle): ")
        #if os(iOS)
            .navigationBarTitleDisplayMode(.automatic)
        #endif
    }

    func fetchEpisodes() {
        guard let url = URL(string: "\(baseRestServerAddress)/api/Command/GetStreamEpisodes?seriesName=\(seriesName)&streamIndex=\(streamIndex)") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }

            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([Episode].self, from: data)
                    DispatchQueue.main.async {
                        self.episodes = decodedData
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }

        task.resume()
    }
}

#Preview {
    EpisodeListView(seriesTitle: "", seriesName: "", streamIndex: 0)
}
