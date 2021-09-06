//
//  FeedViewController.swift
//  InstaCloneFB
//
//  Created by Logan Roth on 2021-01-03.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var cellData = [[String:Any]]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        getDataFromFirestore()
        // Do any additional setup after loading the view.
    }
    
    func getDataFromFirestore() {
        let firestoreDB = Firestore.firestore()
        firestoreDB.collection("Posts").order(by: "date", descending: true).addSnapshotListener { (querySnap, error) in
            if error != nil {
                print("error")
            } else {
                if  querySnap != nil && querySnap?.isEmpty != true {
                    self.cellData.removeAll(keepingCapacity: false)
                    for doc in querySnap!.documents {
                        if let postedBy = doc.get("postedBy") as? String {
                            if let comment = doc.get("comment") as? String {
                                if let likes = doc.get("likes") as? Int {
                                    if let imageUrl = doc.get("imageUrl") as? String {
                                        self.cellData.append(["postedBy": postedBy, "comment": comment, "likes": likes, "imageUrl": imageUrl, "docId": doc.documentID])
                                        self.tableView.reloadData()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! FeedCell
        
        cell.userLabel.text = cellData[indexPath.row]["postedBy"] as? String
        cell.commentLabel.text = cellData[indexPath.row]["comment"] as? String
        let likeNum = cellData[indexPath.row]["likes"] as? Int ?? 0
        cell.likes = likeNum
        cell.likesLabel.text = "Likes: \(likeNum)"
        let urlStr = self.cellData[indexPath.row]["imageUrl"] as! String
        cell.iamgeView!.sd_setImage(with: URL(string: urlStr))
        cell.docLabel.text = cellData[indexPath.row]["docId"] as? String
        return cell
    }
    

}
