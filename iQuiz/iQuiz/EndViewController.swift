//
//  EndViewController.swift
//  iQuiz
//
//  Created by Kelley Lu Chen on 11/13/17.
//  Copyright © 2017 Kelley Lu Chen. All rights reserved.
//

import UIKit

class EndViewController: UIViewController {

    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var total: UILabel!
    var totalQuestion = 0
    var score = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if (score == totalQuestion) {
            comment.text = "EXCELLENT!"
        } else if (score == 0) {
            comment.text = "Good effort!"
        } else {
            comment.text = "Good job!"
        }
        total.text = "\(score) / \(totalQuestion)"
    }

    
    @IBAction func backPressd(_ sender: Any) {
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
