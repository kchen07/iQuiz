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
    var mathQuestion : [(questionText: String, answer: Int, answers: [String])] =  [(questionText: "Something?", answer: 1, answers: ["One","Two","Three", "Four"])]
    var scienceQuestion : [(questionText: String, answer: Int, answers: [String])] =  [(questionText: "Something?", answer: 1, answers: ["One","Two","Three", "Four"])]
    var marvelQuestion : [(questionText: String, answer: Int, answers: [String])] =  [(questionText: "Something?", answer: 1, answers: ["One","Two","Three", "Four"])]
    var questions = [[(questionText: String, answer: Int, answers: [String])]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        questions.append(marvelQuestion)
        questions.append(mathQuestion)
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

