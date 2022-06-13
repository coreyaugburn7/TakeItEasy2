//
//  GameViewController.swift
//  TakeItEasy2
//
//  Created by Maximilian Stump on 6/13/22.
//

import UIKit

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var gameModels = [Question]()
    @IBOutlet var label : UILabel!
    @IBOutlet var table : UITableView!
    
    var currentQ: Question?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpQ()

        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configUI(question : gameModels.first!)
    }
    private func configUI(question: Question){
        label.text = question.text
        currentQ = question
        table.delegate = self
        table.dataSource = self
        
        
    }
    private func checkAns(answer : Answer, question : Question) -> Bool{
        //if question.answers.contains(where: {$0.text == answer.text }) && answer.correct{
            return question.answers.contains(where: {$0.text == answer.text }) && answer.correct
        
        
    }
    
    
    private func setUpQ(){
        gameModels.append(Question(text: "What is 2 + 2", answers: [
            Answer(text: "1", correct: false),
            Answer(text: "5", correct: false),
            Answer(text: "2", correct: true),
            Answer(text: "3", correct: false)
        ]))
        gameModels.append(Question(text: "What is 2 + 5", answers: [
            Answer(text: "1", correct: false),
            Answer(text: "7", correct: true),
            Answer(text: "2", correct: false),
            Answer(text: "3", correct: false)
        ]))
        gameModels.append(Question(text: "What is 2 + 10", answers: [
            Answer(text: "12", correct: true),
            Answer(text: "5", correct: false),
            Answer(text: "2", correct: false),
            Answer(text: "3", correct: false)
        ]))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentQ?.answers.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = currentQ?.answers[indexPath.row].text
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let question = currentQ else{
            return
        }
        let answer = question.answers[indexPath.row]
        
        if checkAns(answer: answer, question: question){
            if let index = gameModels.firstIndex(where: {$0.text == currentQ?.text}){
                if index < (gameModels.count - 1){
                    //next q
                }else{
                    //end of game
                }
                    
            }
        }else{
            let alert = UIAlertController(title: "Wrong", message: "Incorrect answer", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            
        }
    }

}

struct Question {
    let text: String
    let answers : [Answer]
}

struct Answer {
    let text : String
    let correct : Bool
}
