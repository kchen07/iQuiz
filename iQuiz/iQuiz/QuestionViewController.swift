//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Kelley Lu Chen on 11/12/17.
//  Copyright © 2017 Kelley Lu Chen. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    var questions = [(questionText: String, answer: Int, answers: [String])]()
    var questionNum = 0
    var score = 0
    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    fileprivate var answerView: AnswerViewController?
    var ans = [UIButton]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionText.text = questions[questionNum].questionText
        questionNumber.text = "Question \(questionNum + 1):"
        option1.setTitle(questions[questionNum].answers[0], for: .normal)
        option2.setTitle(questions[questionNum].answers[1], for: .normal)
        option3.setTitle(questions[questionNum].answers[2], for: .normal)
        option4.setTitle(questions[questionNum].answers[3], for: .normal)
        ans = [option1, option2, option3, option4]
    }

    @IBAction func backPressed(_ sender: Any) {
        let changeView = CATransition()
        changeView.duration = 0.3
        changeView.type = kCATransitionPush
        changeView.subtype = kCATransitionFromLeft
        view.window!.layer.add(changeView, forKey: kCATransition)
        present((storyboard?.instantiateViewController(withIdentifier: "mainPage"))!, animated: false, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var chose1 = false
    var chose2 = false
    var chose3 = false
    var chose4 = false
    
    @IBOutlet weak var choise2: UIButton!
    @IBOutlet weak var choice1: UIButton!
    @IBOutlet weak var choise3: UIButton!
    @IBOutlet weak var choise4: UIButton!
    @IBAction func c1(_ sender: Any) {
        chose1 = true
        chose2 = false
        chose3 = false
        chose4 = false
        colorOption()
    }
    
    @IBAction func c2(_ sender: Any) {
        chose1 = false
        chose2 = true
        chose3 = false
        chose4 = false
        colorOption()
    }
    @IBAction func c3(_ sender: Any) {
        chose1 = false
        chose2 = false
        chose3 = true
        chose4 = false
        colorOption()
    }
    
    @IBAction func c4(_ sender: Any) {
        chose1 = false
        chose2 = false
        chose3 = false
        chose4 = true
        colorOption()
    }
    
    func colorOption() {
        if (chose1) {
            choice1.backgroundColor = UIColor.lightGray
            choise2.backgroundColor = UIColor.clear
            choise3.backgroundColor = UIColor.clear
            choise4.backgroundColor = UIColor.clear

        } else if (chose2) {
            choice1.backgroundColor = UIColor.clear
            choise2.backgroundColor = UIColor.lightGray
            choise3.backgroundColor = UIColor.clear
            choise4.backgroundColor = UIColor.clear
            
        } else if (chose3) {
            choice1.backgroundColor = UIColor.clear
            choise2.backgroundColor = UIColor.clear
            choise3.backgroundColor = UIColor.lightGray
            choise4.backgroundColor = UIColor.clear

        } else {
            choice1.backgroundColor = UIColor.clear
            choise2.backgroundColor = UIColor.clear
            choise3.backgroundColor = UIColor.clear
            choise4.backgroundColor = UIColor.lightGray
        }
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        createAnswer()
        answerView?.correctAnswer = self.questions[questionNum].answers[questions[questionNum].answer - 1]
        answerView?.questions = self.questions
        answerView?.questionNum = self.questionNum
        answerView?.score = self.score
        var corr:Bool = false
        if (questions[questionNum].answer == 1) {
            corr = chose1
        } else if (questions[questionNum].answer == 2) {
            corr = chose2
        } else if (questions[questionNum].answer == 3) {
            corr = chose3
        } else {
            corr = chose4
        }
        answerView?.correct = corr
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        present(answerView!, animated: false, completion: nil)
    }
    
    func createAnswer() {
        if answerView == nil {
            answerView =
                storyboard?
                    .instantiateViewController(withIdentifier: "answerView")
                as? AnswerViewController
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
