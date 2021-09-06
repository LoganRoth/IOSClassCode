//
//  ViewController.swift
//  BirthdayNote
//
//  Created by Logan Roth on 2020-12-13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var birthdayText: UITextField!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let name = UserDefaults.standard.object(forKey: "name")
        let bday = UserDefaults.standard.object(forKey: "birthday")
        if let myName = name as? String {
            nameLabel.text = "Name: \(myName)"
        }
        if let myBday = bday as? String {
            birthdayLabel.text = "Birthday \(myBday)"
        }
        
    }

    @IBAction func saveClick(_ sender: Any) {
        UserDefaults.standard.set(nameText.text!, forKey: "name")
        UserDefaults.standard.set(birthdayText.text!, forKey: "birthday")
        nameLabel.text = "Name: \(nameText.text!)"
        birthdayLabel.text = "Birthday: \(birthdayText.text!)"
    }
    @IBAction func deleteClick(_ sender: Any) {
        let name = UserDefaults.standard.object(forKey: "name")
        let bday = UserDefaults.standard.object(forKey: "birthday")
        if (name as? String) != nil {
            UserDefaults.standard.removeObject(forKey: "name")
            nameLabel.text = "Name: "
        }
        if (bday as? String) != nil {
            UserDefaults.standard.removeObject(forKey: "birthday")
            birthdayLabel.text = "Birthday: "
        }
    }
    
}

