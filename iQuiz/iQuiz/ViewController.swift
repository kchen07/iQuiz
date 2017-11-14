//
//  ViewController.swift
//  iQuiz
//
//  Created by Kelley Lu Chen on 11/6/17.
//  Copyright © 2017 Kelley Lu Chen. All rights reserved.
//


import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let categories = ["Mathematics", "Marvel Super Heros", "Science"]
    let descriptions = ["Math related questions", "Are you a true marvel fan?", "Prove that you are a scientist"]
    let images = ["math", "marvel", "science"]
    var mathQuestion : [(questionText: String, answer: Int, answers: [String])] =  [(questionText: "What is 3 - 2?", answer: 3, answers: ["-1","5","1", "6"])]
    var scienceQuestion : [(questionText: String, answer: Int, answers: [String])] =  [(questionText: "Which one is not part of dna sequence?", answer: 2, answers: ["A","B","C", "T"]), (questionText: "What is the value of acceleration due to gravity?", answer: 4, answers: ["10 miles/hour","23.2 km/s","9.81 km/minute", "9.81 km/second"])]
    var marvelQuestion : [(questionText: String, answer: Int, answers: [String])] = [(questionText: "Who saved spiderman from the hulk?", answer: 3, answers: ["Wolverine","She-Hulk","Captain America", "Dare Devil"]), (questionText: "Who is Iron Man?", answer: 1, answers: ["Tony Stark","Jane Foster","Liam Smith", "Hugh Banner"]), (questionText: " How many Avengers are there in the Avengers movie?", answer: 2, answers: ["2","6","4", "7"])]
    var questions = [[(questionText: String, answer: Int, answers: [String])]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        questions.append(mathQuestion)
        questions.append(marvelQuestion)
        questions.append(scienceQuestion)
    }
    fileprivate var questionView: QuestionViewController?

    @IBAction func settingPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Setting", message: "Settings go here", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        var col = UIColor(hue: 184/360, saturation: 33/100, brightness: 99/100, alpha: 1.0) /* #a9f6fc */
        cell.backgroundColor = col
        cell.textLabel!.text = categories[indexPath.row]
        cell.detailTextLabel!.text = descriptions[indexPath.row]
        cell.imageView?.image = UIImage(named: images[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // do view switch when the user choose one cell
        createQuestionView()
        questionView?.questions = self.questions[indexPath.row]
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        present(questionView!, animated: false, completion: nil)
    }

    
    fileprivate func createQuestionView() {
        if questionView == nil {
            questionView =
                storyboard?
                    .instantiateViewController(withIdentifier: "questionView")
                as? QuestionViewController
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

