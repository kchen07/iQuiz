//
//  ViewController.swift
//  iQuiz
//
//  Created by Kelley Lu Chen on 11/6/17.
//  Copyright © 2017 Kelley Lu Chen. All rights reserved.
//


import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var table: UITableView!
    let questionURL = "http://tednewardsandbox.site44.com/questions.json"
    var categories = ["Mathematics", "Marvel Super Heros", "Science"]
    var descriptions = ["Math related questions", "Are you a true marvel fan?", "Prove that you are a scientist"]
    let images = ["math", "marvel", "science"]
    var mathQuestion : [(questionText: String, answer: Int, answers: [String])] =  [(questionText: "What is 3 - 2?", answer: 3, answers: ["-1","5","1", "6"])]
    var scienceQuestion : [(questionText: String, answer: Int, answers: [String])] =  [(questionText: "Which one is not part of dna sequence?", answer: 2, answers: ["A","B","C", "T"]), (questionText: "What is the value of acceleration due to gravity?", answer: 4, answers: ["10 miles/hour","23.2 km/s","9.81 km/minute", "9.81 km/second"])]
    var marvelQuestion : [(questionText: String, answer: Int, answers: [String])] = [(questionText: "Who saved spiderman from the hulk?", answer: 3, answers: ["Wolverine","She-Hulk","Captain America", "Dare Devil"]), (questionText: "Who is Iron Man?", answer: 1, answers: ["Tony Stark","Jane Foster","Liam Smith", "Hugh Banner"]), (questionText: " How many Avengers are there in the Avengers movie?", answer: 2, answers: ["2","6","4", "7"])]
    var questions = [[(questionText: String, answer: Int, answers: [String])]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        questions.append(mathQuestion)
        questions.append(scienceQuestion)
        questions.append(marvelQuestion)
        // Do any additional setup after loading the view, typically from a nib.
        loadQuestionsData(json_url: questionURL)
    }
    fileprivate var questionView: QuestionViewController?

    private func loadQuestionsData(json_url: String) {

        var url = URL(string: json_url)
        if (url == nil) {
            url = URL(string: questionURL)
        }
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error == nil {
                self.categories.removeAll(keepingCapacity: true)
                self.descriptions.removeAll(keepingCapacity: true)
                self.questions.removeAll()
                do {
                    let json = try JSONSerialization.jsonObject(with: data!) as? [[String: Any]]
                    var index1 : Int = 0
                    for dict in json! {
                        let cat = dict["title"] as! String
                            self.categories.append(cat)
                            self.descriptions.append(dict["desc"] as! String)
                        
                        if let qs = dict["questions"] as? [[String: Any]] {
                            let questn = [(questionText: String, answer: Int, answers: [String])]()
                            self.questions.append(questn)
                            for q in qs {
                                var questiont = ""
                                if let qText : String = q["text"] as? String {
                                    questiont = qText
                                }
                                var answ = -1
                                if let ans = q["answer"] as? String {
                                    answ = Int(ans)!
                                }
                                var choices = [""]
                                if let anss : [String] = q["answers"] as? [String] {
                                    choices = anss
                                }
                                self.questions[index1].append((questiont, answ, choices))
                            }
                        }
                        index1 = index1 + 1
                    }
                } catch {
                    print("Error")
                }
            } else {
                NSLog("NO INTERNET")
            }
        }.resume()
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
    
    @IBAction func settingPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Setting", message: "Enter new URL", preferredStyle: .alert)
        
        let checkBtn = UIAlertAction(title: "Check now", style: .default, handler: {
            check -> Void in
            let newURL = alert.textFields![0] as UITextField
            self.loadQuestionsData(json_url: newURL.text!)
        })
        
        let cancelBtn = UIAlertAction(title: "Cancel", style: .default, handler: {_ in NSLog("Cancel")
        })
        
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter URL"
        }
        
        alert.addAction(checkBtn)
        alert.addAction(cancelBtn)
        
        self.present(alert, animated:true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let col = UIColor(hue: 184/360, saturation: 33/100, brightness: 99/100, alpha: 1.0) /* #a9f6fc */
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

