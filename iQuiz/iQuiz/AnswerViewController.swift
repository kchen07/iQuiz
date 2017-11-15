//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Kelley Lu Chen on 11/12/17.
//  Copyright © 2017 Kelley Lu Chen. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {

    @IBOutlet weak var isCorrect: UILabel!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var des: UILabel!
    var desc = ""
    var correctAnswer:String = ""
    fileprivate var questionView: QuestionViewController?
    fileprivate var endView: EndViewController?

    var score = 0
    var questionNum = 0
    var questions = [(questionText: String, answer: Int, answers: [String])]()
    var correct:Bool = false
    

    @IBOutlet weak var resultImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        answer.text = correctAnswer
        if (correct) {
            isCorrect.text = "Correct!"
            resultImage?.image = UIImage(named: "correct")
            score += 1
        } else {
            isCorrect.text = "Incorrect!"
            resultImage.image = UIImage(named: "incorrect")

        }
        des.text = desc
        answer.text = correctAnswer
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextView(_ sender: Any) {
        let changeView = CATransition()
        changeView.duration = 0.3
        changeView.type = kCATransitionPush
        changeView.subtype = kCATransitionFromRight
        if (questionNum + 1 < questions.count) {
            createQuestionView()
            questionView?.questions = self.questions
            questionView?.score = self.score
            questionView?.questionNum = self.questionNum + 1
            view.window!.layer.add(changeView, forKey: kCATransition)
            present(questionView!, animated: false, completion: nil)
        } else {
            createEndView()
            endView?.score = self.score
            endView?.totalQuestion = questionNum + 1
            view.window!.layer.add(changeView, forKey: kCATransition)
            present(endView!, animated: false, completion: nil)
        }
    }
    fileprivate func createQuestionView() {
        if questionView == nil {
            questionView =
                storyboard?
                    .instantiateViewController(withIdentifier: "questionView")
                as? QuestionViewController
        }
    }
    
    fileprivate func createEndView() {
        if endView == nil {
            endView =
                storyboard?
                    .instantiateViewController(withIdentifier: "endView")
                as? EndViewController
        }
    }
    
    @IBAction func backPressed(_ sender: Any) {
        let changeView = CATransition()
        changeView.duration = 0.3
        changeView.type = kCATransitionPush
        changeView.subtype = kCATransitionFromLeft
        view.window!.layer.add(changeView, forKey: kCATransition)
        present((storyboard?.instantiateViewController(withIdentifier: "mainPage"))!, animated: false, completion: nil)
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
