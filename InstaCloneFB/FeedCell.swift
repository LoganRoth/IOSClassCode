//
//  FeedCell.swift
//  InstaCloneFB
//
//  Created by Logan Roth on 2021-01-03.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {
    // Vars
    var liked = false
    var likes : Int!

    // Views
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var iamgeView: UIImageView!
    @IBOutlet weak var docLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likeButtonClicked(_ sender: Any) {
        let firestoreDB = Firestore.firestore()
        
        var likeStore : [String:Any]
        if !liked {
            liked = true
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: UIControl.State.normal)
            likeStore = ["likes": likes + 1] as [String:Any]
        } else {
            liked = false
            likeButton.setImage(UIImage(systemName: "heart"), for: UIControl.State.normal)
            likeStore = ["likes": likes - 1] as [String:Any]
        }
        // Obviously doesn't work fully, need to track who has liked and stuff
        firestoreDB.collection("Posts").document(docLabel.text!).setData(likeStore, merge: true)
    }
    
}
