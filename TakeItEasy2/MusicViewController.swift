//
//  MusicViewController.swift
//  TakeItEasy2
//
//  Created by Corey Augburn on 6/10/22.
//

import UIKit
import AVFoundation

class MusicViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate, UICollectionViewDelegateFlowLayout{
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    var audioPlayer : AVAudioPlayer?
    var musicFile : String?
    var timer : Timer?
    var filteredData = [String]()
    var filtered = false
    
    
    @IBOutlet weak var timeStamp: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var searchMusic: UITextField!
    
    @IBOutlet weak var volumeSlider: UISlider!
    
    @IBOutlet weak var table: UICollectionView!
    
    var dataImg = ["Casemissingyou", "love", "Green_Day"]
    
    var dataText = ["Case", "love", "Green Day"]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if !filteredData.isEmpty{
            return filteredData.count
            
        }
        
        return filtered ? 0 : dataText.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MusicCollectionViewCell
        
        if !filteredData.isEmpty{
            myCell.musicLabel.text = filteredData[indexPath.row]
        }else{
            myCell.musicLabel.text = dataText[indexPath.row]
            myCell.musicImg.image = UIImage(named: dataImg[indexPath.row])
        }
        
        return myCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print(dataText[indexPath.row])
            audioPlayer?.prepareToPlay()
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            let filePath = Bundle.main.path(forResource: "Case", ofType: "mp3")
            let newurl = URL(fileURLWithPath: filePath!)

            do{
                audioPlayer = try AVAudioPlayer(contentsOf: newurl)
                        audioPlayer?.play()
            }catch{
                print("file not found")
            }
        case 1:
            print(dataText[indexPath.row])
            audioPlayer?.prepareToPlay()
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            let filePath = Bundle.main.path(forResource: "love", ofType: "mp3")
            let newurl = URL(fileURLWithPath: filePath!)

            do{
                audioPlayer = try AVAudioPlayer(contentsOf: newurl)
                        audioPlayer?.play()
            }catch{
                print("file not found")
            }
        case 2:
            print(dataText[indexPath.row])
            audioPlayer?.prepareToPlay()
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            let filePath = Bundle.main.path(forResource: "Green Day", ofType: "mp3")
            let newurl = URL(fileURLWithPath: filePath!)

            do{
                audioPlayer = try AVAudioPlayer(contentsOf: newurl)
                        audioPlayer?.play()
            }catch{
                print("file not found")
            }
        default:
            print("")
        }
    }
    
    
    @IBAction func playBtn(_ sender: Any) {
        
        for song in dataText{
            if song.lowercased() == searchMusic.text!.lowercased(){
                audioPlayer?.prepareToPlay()
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
                let filePath = Bundle.main.path(forResource: song, ofType: "mp3")
                let newurl = URL(fileURLWithPath: filePath!)


                do{
                    audioPlayer = try AVAudioPlayer(contentsOf: newurl)
                            audioPlayer?.play()
                }catch{
                    print("file not found")
                }
            }
        }
    }
    
    
    @objc func updateTime(){
        //sets time to result
        timeStamp.text = audioPlayer!.currentTime.description
        progressView.progress = Float(audioPlayer!.currentTime)/Float(audioPlayer!.duration)
    
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let text = searchMusic.text{
                if string.count == 0{
                    filterText(String(text.dropLast()))
                    
                    print(text)
                }
                filterText(text+string)
            }
            return true
        }
        
        func filterText(_ query: String){
            filteredData.removeAll()
            for string in dataText {
                if string.lowercased().starts(with: query.lowercased()){
                    filteredData.append(string)
                    
                }
            }
            table.reloadData()
            filtered = true
        }
    
    
}
}
