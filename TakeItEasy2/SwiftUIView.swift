//
//  SwiftUIView.swift
//  TakeItEasy2
//
//  Created by Corey Augburn on 6/13/22.
//

import SwiftUI


    

//
//
//struct SwiftUIView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView()
//    }
//}


    
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        MusicAPI.ContentView
//    }
    
//    static var player = MusicAPI()
    
    
struct Result: Codable{
    
    let trackId: Int
    let trackName: String
    let collectionName: String
    
}


struct Response: Codable{
    let results: [Result]
    
}

//changed from content view
struct SwiftUIView: View{
    @State var results = [Result]()
    
    var body: some View{
        Text("somethings working")
        NavigationView{
            List(results, id:\.trackId ){ item in
                VStack(alignment:.leading){
                    
                    Text(item.trackName)
                        .font(.headline)
                    Text(item.collectionName)
                }
            }.onAppear(perform: loadData)
                .navigationBarTitle("Music")
            }
        }
        
        func loadData(){
            
            guard let url = URL(string: "http://itunes.apple.com/search?term=taylor+swift&entity=song")
            else{
                print("Invalid URL")
                return
            }
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request){data, response, error in
                
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data){
                        
                        DispatchQueue.main.async {
                            self.results = decodedResponse.results
                        }
                        return
                    }
                }
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
                
            }.resume()
        }
}





