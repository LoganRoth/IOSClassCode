//
//  UploadViewController.swift
//  InstaCloneFB
//
//  Created by Logan Roth on 2021-01-03.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.isUserInteractionEnabled = true
        let gestRec = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestRec)
    }
    
    func makeAlert(title:String, msg:String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func chooseImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func uploadClicked(_ sender: Any) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let mediaFolder = storageRef.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            let myUUID = UUID().uuidString
            let imageRef = mediaFolder.child("\(myUUID).jpg")
            imageRef.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    self.makeAlert(title: "Error!", msg: error?.localizedDescription ?? "Error")
                } else {
                    imageRef.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            let firestoreDB = Firestore.firestore()
                            var firestoreRef : DocumentReference? = nil
                            
                            let firestorePost = ["imageUrl": imageUrl!, "postedBy": Auth.auth().currentUser!.email!, "comment": self.commentField.text!, "likes": 0, "date": FieldValue.serverTimestamp()] as [String : Any]
                            
                            firestoreRef = firestoreDB.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
                                if error != nil {
                                    self.makeAlert(title: "Error!", msg: error?.localizedDescription ?? "Error")
                                } else {
                                    self.imageView.image = UIImage(systemName: "camera.circle")
                                    self.commentField.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                        }
                    }
                }
            }
        }
    }
}
