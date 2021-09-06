//
//  UploadVC.swift
//  SnapchatClone
//
//  Created by Logan Roth on 2021-01-09.
//

import UIKit
import Firebase

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        
        let gestRec = UIGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestRec)
        // Do any additional setup after loading the view.
    }
    
    @objc func chooseImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
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
            let uuid = UUID().uuidString
            
            let imageRef = mediaFolder.child("\(uuid).jpg")
            
            imageRef.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    self.makeAlert(title: "Error", msg: error?.localizedDescription ?? "Error")
                } else {
                    imageRef.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            
                            let fs = Firestore.firestore()
                            
                            fs.collection("Snaps").whereField("snapOwner", isEqualTo: UserSingleton.sharedUserInfo.username).getDocuments { (snap, error) in
                                if error != nil {
                                    self.makeAlert(title: "Error", msg: error?.localizedDescription ?? "Error")
                                } else {
                                    if snap != nil && snap?.isEmpty == false {
                                        for doc in snap!.documents {
                                            let docId = doc.documentID
                                            if var imageUrlArr = doc.get("imageUrlArray") as? [String] {
                                                imageUrlArr.append(imageUrl!)
                                                
                                                let addDict = ["imageUrlArray" : imageUrlArr] as [String : Any]
                                                
                                                fs.collection("Snaps").document(docId).setData(addDict, merge: true) { (error) in
                                                    if error == nil {
                                                        self.tabBarController?.selectedIndex = 0
                                                        self.imageView.image = UIImage(systemName: "camera.circle")
                                                    }
                                                }
                                            }
                                        }
                                    } else {
                                        let snapDict = ["imageUrlArrary": imageUrl!, "snapOwner": UserSingleton.sharedUserInfo.username, "date": FieldValue.serverTimestamp()] as [String : Any]
                                        
                                        fs.collection("Snaps").addDocument(data: snapDict) { (error) in
                                            if error != nil {
                                                self.makeAlert(title: "Error", msg: error?.localizedDescription ?? "Error")
                                            } else {
                                                self.tabBarController?.selectedIndex = 0
                                                self.imageView.image = UIImage(systemName: "camera.circle")
                                            }
                                        }
                                    }
                                }
                            }
                            
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
}
