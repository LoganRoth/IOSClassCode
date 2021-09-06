//
//  FeedVC.swift
//  SnapchatClone
//
//  Created by Logan Roth on 2021-01-09.
//

import UIKit
import Firebase
import SDWebImage

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let fs = Firestore.firestore()
    var snapArray = [SnapModel]()
    var chosenSnap : SnapModel?
    var timeLeft : Int?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getSnapsFromFB()
        
        getUserInfo()
    }
    
    func getSnapsFromFB() {
        fs.collection("Snaps").order(by: "data",descending: true).addSnapshotListener { (snap, error) in
            if error != nil {
                self.makeAlert(title: "Error", msg: error?.localizedDescription ?? "Error")
            } else {
                if snap != nil && snap?.isEmpty == false {
                    self.snapArray.removeAll(keepingCapacity: false)
                    for doc in snap!.documents {
                        let docId = doc.documentID
                        if let username = doc.get("snapOwnder") as? String {
                            if let imageUrlArray = doc.get("imageUrlArray") as? [String] {
                                if let date = doc.get("date") as? Timestamp {
                                    let myDate = date.dateValue()
                                    if let diff = Calendar.current.dateComponents([.hour], from: myDate, to: Date()).hour {
                                        if diff >= 24 {
                                            self.fs.collection("Snaps").document(docId).delete { (error) in
                                                if error != nil {
                                                    //
                                                }
                                            }
                                        } else {
                                            let newSnap = SnapModel(username: username, imageUrlArray: imageUrlArray, date: myDate, timeLeft: 24 - diff)
                                            self.snapArray.append(newSnap)
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func getUserInfo() {
        fs.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { (snap, error) in
            if error != nil {
                self.makeAlert(title: "Error", msg: error?.localizedDescription ?? "Error")
            } else {
                if snap != nil && snap?.isEmpty == false {
                    for doc in snap!.documents {
                        if let username = doc.get("username") as? String {
                            UserSingleton.sharedUserInfo.email = Auth.auth().currentUser!.email!
                            UserSingleton.sharedUserInfo.username = username
                        }
                    }
                }
            }
        }
    }
    
    func makeAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        alert.present(alert, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snapArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.feedLabel.text = snapArray[indexPath.row].username
        cell.feedImage.sd_setImage(with: URL(string: snapArray[indexPath.row].imageUrlArray[0]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenSnap = self.snapArray[indexPath.row]
        performSegue(withIdentifier: "toSnapVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSnapVC" {
            let destVC = segue.destination as! SnapVC
            destVC.selSnap = chosenSnap
        }
    }
    
    
}
