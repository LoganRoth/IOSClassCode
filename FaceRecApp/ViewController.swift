//
//  ViewController.swift
//  FaceRecApp
//
//  Created by Logan Roth on 2021-01-03.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInClicked(_ sender: Any) {
        let authCtx = LAContext()
        var error: NSError?
        
        if authCtx.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            authCtx.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Is it you?") {
                (success, err) in
                if success == true {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "toSuccess", sender: nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.myLabel.text = "Error!"
                    }
                }
            }
        }
        
    }
    
}

