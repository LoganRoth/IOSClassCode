//
//  SettingsViewController.swift
//  InstaCloneFB
//
//  Created by Logan Roth on 2021-01-03.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toLogin", sender: nil)
        } catch {
            print("error")
        }
    }
    
}
