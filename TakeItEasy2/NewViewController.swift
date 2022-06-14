//
//  NewViewController.swift
//  TakeItEasy2
//
//  Created by Corey Augburn on 6/13/22.
//

//import UIKit
import SwiftUI

//class NewViewController: UIViewController {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
    
//    struct Result: Codable{
//
//        let trackId: Int
//        let trackName: String
//        let collectionName: String
//
//    }
//
//
//    struct Response: Codable{
//        let results: [Result]
//
//
//    }
//
//    struct ContentView: View{
//        @State var results = [Result]()
//
//        var body: some View{
//            NavigationView{
//                List(results, id:\.trackId ){ item in
//                    VStack(alignment:.leading){
//
//                        Text(item.trackName)
//                            .font(.headline)
//                        Text(item.collectionName)
//                    }
//                }.onAppear(perform: loadData)
//                    .navigationBarTitle("Music")
//                }
//            }
//
//            func loadData(){
//
//                guard let url = URL(string: "http://itunes.apple.com/search?term=taylor+swift&entity=song")
//                else{
//                    print("Invalid URL")
//                    return
//                }
//                let request = URLRequest(url: url)
//                URLSession.shared.dataTask(with: request){data, response, error in
//
//                    if let data = data {
//                        if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data){
//
//                            DispatchQueue.main.async {
//                                self.results = decodedResponse.results
//                            }
//                            return
//                        }
//                    }
//                    print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
//
//                }.resume()
//            }
//    }
//
//
//
 

//}
