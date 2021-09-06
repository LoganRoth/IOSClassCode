//
//  ViewController.swift
//  howManyFingers
//
//  Created by Logan Roth on 2019-06-09.
//  Copyright © 2019 FrightenedPony. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var OutputTxt: UILabel!
    @IBOutlet weak var GuessField: UITextField!
    @IBAction func GuessButton(_ sender: Any) {
        let num = arc4random_uniform(6)
        if num == Int(GuessField.text ?? "-1") ?? -1 {
            OutputTxt.text = "You're Right!"
        } else {
            OutputTxt.text = "Sorry! It was a " + String(num)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

