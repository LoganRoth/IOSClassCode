//
//  ViewController.swift
//  SnapchatClone
//
//  Created by Logan Roth on 2021-01-09.
//

import UIKit
import Firebase

class SignInVC: UIViewController {

    //Variables
    
    // Views
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginClicked(_ sender: Any) {
        if passwordField.text != "" && emailField.text != "" {
            Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (res, error) in
                if error != nil {
                    self.makeAlert(title: "Error", msg: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        } else {
            self.makeAlert(title: "Error", msg: "Password/Email?")
            
        }
        
    }
    
    @IBAction func signupClicked(_ sender: Any) {
        if usernameField.text != "" && passwordField.text != "" && emailField.text != "" {
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { (auth, error) in
                if error != nil {
                    self.makeAlert(title: "Error", msg: error?.localizedDescription ?? "Error")
                } else {
                    let fs = Firestore.firestore()
                    let userDict = ["email": self.emailField.text!, "username": self.usernameField.text!] as [String: Any]
                    fs.collection("UserInfo").addDocument(data: userDict) { (error) in
                        if error != nil {
                            self.makeAlert(title: "Error", msg: error?.localizedDescription ?? "Error")
                        }
                    }
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            self.makeAlert(title: "Error", msg: "Username/Password/Email?")
        }
    }
    
    func makeAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        alert.present(alert, animated: true, completion: nil)
    }
}

