import SwiftUI

struct ContentView: View {
    @State private var seriesName: String = ""
    @State private var selection = 15
    @State private var seriesItems: [SeriesItem] = []
    @State private var focusedIndex: Int?
    
    let indexPlaceholder = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    public var baseRestServerAddress: String = "http://12.34.56.789:8762"
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter series/movie name", text: $seriesName)
                        .padding()
                    #if os(iOS)
                        .textFieldStyle(.roundedBorder)
                    #endif
                    
                    #if os(tvOS)
                    Picker("Index:", selection: $selection) {
                        ForEach(indexPlaceholder, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.menu)
                    #endif
                }
                
                HStack {
                    #if os(tvOS)
                    NavigationLink(destination: EpisodeListView(seriesTitle: seriesName, seriesName: seriesName, streamIndex: selection)) {
                        Button("I know my index!") {
                            print("test")
                        }.padding().buttonStyle(.bordered)
                    }.buttonStyle(PlainButtonStyle())
                    #endif

                    Button("Show me everything!") {
                        fetchSeries()
                    }
                    .padding().buttonStyle(.bordered)
                }
                
                List(seriesItems) { item in
                    NavigationLink(destination: EpisodeListView(seriesTitle: item.Title,seriesName: seriesName, streamIndex: item.Index)) {
                        Text("Nr.\(item.Index)  |  \(item.Title)").padding()
                    }
                }
            }
            .navigationTitle("RestVideoStream")
        #if os(iOS)
            .navigationBarTitleDisplayMode(.automatic)
        #endif
            
        }
    }

    func fetchSeries() {
        guard let url = URL(string: "\(baseRestServerAddress)/api/Command/GetStreamIndexes?seriesName=\(seriesName)") else {
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
                    let decodedData = try JSONDecoder().decode([SeriesItem].self, from: data)
                    DispatchQueue.main.async {
                        self.seriesItems = decodedData
                        seriesItems.reverse()
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }

        task.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
