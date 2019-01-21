//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
//    Setting "allQuestions" equal to question bank object created in QuestionBank.swift (line 11)
    let allQuestions = QuestionBank();
    var pickedAnswer : Bool = false;
    var questionNumber : Int = 0;
    var score : Int = 0;
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Loads first question onto the screen
////        let firstQuestion = allQuestions.list[0]
////        Targets the question label in the main.storyboard and sets the text to equal the STRING of the first question (it has 2 properties, a string and a boolean
//        questionLabel.text = firstQuestion.questionText
        
        //        Changed code to function "nextQuestion" to cut back on code:
        nextQuestion()
        
    }
    
    


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1{
            pickedAnswer = true
        }else if sender.tag == 2{
            pickedAnswer = false
        }
        
        checkAnswer()
        questionNumber += 1;
        nextQuestion()
    }
    
    
    func updateUI() {
        
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber + 1) / 13"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber + 1)
        
    }
    

    func nextQuestion() {
        if questionNumber <= 12 {
            
        questionLabel.text = allQuestions.list[questionNumber].questionText
            
        updateUI()
        } else{
            
            let alert = UIAlertController(title: "Great!", message: "You've finished the questions! Would you like to start over?", preferredStyle:.alert)
            
            let restartAction = UIAlertAction(title:"Restart", style: .default, handler:
            { (UIAlterAction) in
                self.startOver()
            })
            
            alert.addAction(restartAction)
            
            present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    
    func checkAnswer() {
//        Tapping into allQuestions (or the question bank), targeting the first question ("[0]") and it's boolean value (in this case the value = true)
        let correctAnswer = allQuestions.list[questionNumber].answer
    
        if correctAnswer == pickedAnswer{
            ProgressHUD.showSuccess("Correct")
            score += 1;
        } else {
            ProgressHUD.showError("Wrong")
        }
    }
    
    func startOver() {
        questionNumber = 0;
        nextQuestion();
        score = 0;
    }
    

    
}
