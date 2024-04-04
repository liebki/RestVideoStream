import AVKit
import SwiftUI
import AVFoundation

struct VideoPlayerView: View {
    var videoURL: String
    @State private var player = AVPlayer()

    var body: some View {
        ZStack {
            VideoPlayer(player: player)
                .onAppear {
                    setupAudioSession()
                    let playerItem = AVPlayerItem(url: URL(string: videoURL)!)
                    self.player.replaceCurrentItem(with: playerItem)
                    self.player.play()
                }
                .onDisappear {
                    resetAudioSession()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
        }
    }

    func setupAudioSession() {
    #if os(iOS)
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch {
            print("Error setting up audio session: \(error.localizedDescription)")
        }
    #endif
    }

    func resetAudioSession() {
    #if os(iOS)
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient)
        } catch {
            print("Error resetting audio session: \(error.localizedDescription)")
        }
    #endif
    }
}

#Preview {
    VideoPlayerView(videoURL: "")
}
