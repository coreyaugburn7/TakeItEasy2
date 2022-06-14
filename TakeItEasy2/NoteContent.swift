//
//  NoteContent.swift
//  TakeItEasy
//
//  Created by Jacob on 6/9/22.
//

import UIKit
import Speech

class NoteContent: UIViewController {

    var header = ""
    var body = ""
    
    let AudioEngine = AVAudioEngine()
    let speechRecog = SFSpeechRecognizer()
    let bufferRecogReq = SFSpeechAudioBufferRecognitionRequest()
    var recogTask: SFSpeechRecognitionTask!
    var isStart = false
    
    var isActive = false
    
    @IBOutlet weak var microphone: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var content: UITextView!
    
    @IBAction func mic(_ sender: Any) {
        if isActive == false{
            isActive = true
            microphone.tintColor = UIColor.red
            startSpeechRecog()
        }
        else{
            isActive = false
            microphone.tintColor = UIColor.blue
            stopSpeechRecog()
            body = content.text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        microphone.tintColor = UIColor.blue
        name.text = header
        content.text = body
    }
    override func viewDidDisappear(_ animated: Bool) {
        DbHandler.dbHandler.updateNote(orig: header, title: name.text!, body: content.text!)
    }
    
    func startSpeechRecog(){
        let inputN = AudioEngine.inputNode
        let recordF = inputN.outputFormat(forBus: 0)
        inputN.installTap(onBus: 0, bufferSize: 1024, format: recordF){
            buffer, _ in self.bufferRecogReq.append(buffer)
        }
        AudioEngine.prepare()
        do{
            try AudioEngine.start()
        }
        catch{
            print("error")
        }
        recogTask = speechRecog?.recognitionTask(with: bufferRecogReq, resultHandler: {resp, error in
            guard let res = resp else{
                print(error)
                return
            }
            
            let msg = resp?.bestTranscription.formattedString
            print(msg)
            self.content.text = msg
        })
    }
    func stopSpeechRecog(){
        
        recogTask.finish()
        recogTask.cancel()
        recogTask = nil
        body = self.content.text
    }

}
