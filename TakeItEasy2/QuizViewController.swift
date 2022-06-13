//
//  QuizViewController.swift
//  TakeItEasy2
//
//  Created by Maximilian Stump on 6/13/22.
//

/*
 - Menu screen
 - Game screen
 - answer obj
 - question obj
 
 */

import UIKit

class QuizViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startQuiz(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "Game") as! GameViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
