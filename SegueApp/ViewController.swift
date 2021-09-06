//
//  ViewController.swift
//  SegueApp
//
//  Created by Logan Roth on 2020-12-13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var myLabel: UILabel!
    
    var userName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameText.text = ""
    }

    @IBAction func nextClick(_ sender: Any) {
        let alert = UIAlertController(title: "Hi", message: "Sup?", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Okay", style: UIAlertAction.Style.default) { (UIAlertAction) in
            //
        }
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        userName = nameText.text!
        performSegue(withIdentifier: "toSecondVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVC" {
            let destVC = segue.destination as! ViewController2
            destVC.myName = userName
        }
    }
}

