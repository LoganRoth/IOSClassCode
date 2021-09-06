//
//  ViewController2.swift
//  SegueApp
//
//  Created by Logan Roth on 2020-12-15.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var myName = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = "Name: \(myName)"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
