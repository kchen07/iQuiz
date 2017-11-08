//
//  ViewController.swift
//  iQuiz
//
//  Created by Kelley Lu Chen on 11/6/17.
//  Copyright © 2017 Kelley Lu Chen. All rights reserved.
//


import UIKit

class ViewController: UITableViewController {

    let categories = ["Mathematics", "Marvel Super Heros", "Science"]
    let descriptions = ["Math related questions", "Are you a true marvel fan?", "Prove that you are a scientist"]
    let images = ["math", "marvel", "science"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func settingPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Setting", message: "Settings go here", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
      override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        var col = UIColor(hue: 184/360, saturation: 33/100, brightness: 99/100, alpha: 1.0) /* #a9f6fc */

        cell.backgroundColor = col
        cell.textLabel!.text = categories[indexPath.row]
        cell.detailTextLabel!.text = descriptions[indexPath.row]
        cell.imageView?.image = UIImage(named: images[indexPath.row])
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

