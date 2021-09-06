//
//  ViewController.swift
//  Gestures
//
//  Created by Logan Roth on 2020-12-15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    
    var timer = Timer()
    var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counter = 10
        myLabel.text = "Time: \(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
    }

    @objc func timerFunc() {
        myLabel.text = "Time: \(counter)"
        counter -= 1
        if counter == 0 {
            timer.invalidate()
            myLabel.text = "Time is up!"
        }
    }

    @IBAction func startTimer(_ sender: Any) {
    }
    
}

