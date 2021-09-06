//
//  ViewController.swift
//  InstaCloneFB
//
//  Created by Logan Roth on 2021-01-03.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginClicked(_ sender: Any) {
        if emailField.text != "" && passField.text != "" {
            Auth.auth().signIn(withEmail: emailField.text!, password: passField.text!) { (authdata, error) in
                if error != nil {
                    self.makeAlert(title: "Error!", msg: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            makeAlert(title: "Error!", msg: "Email/Password?")
        }
    }
    
    @IBAction func signupClicked(_ sender: Any) {
        if emailField.text != "" && passField.text != "" {
            Auth.auth().createUser(withEmail: emailField.text!, password: passField.text!) { (authdata, error) in
                if error != nil {
                    self.makeAlert(title: "Error!", msg: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            makeAlert(title: "Error!", msg: "Email/Password?")
        }
    }
    
    func makeAlert(title:String, msg:String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

