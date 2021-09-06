//
//  DetailsVC.swift
//  ArtBook
//
//  Created by Logan Roth on 2020-12-21.
//

import UIKit
import CoreData

class DetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // Variables
    var selArt : UUID?
    var selArtName = ""
    
    // Views
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var artistField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    @IBOutlet weak var saveButtonView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButtonView.isEnabled = false
        if selArtName != "" {
            saveButtonView.isHidden = true
            let appDel = UIApplication.shared.delegate as! AppDelegate
            let ctx = appDel.persistentContainer.viewContext
            
            let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let idStr = selArt?.uuidString
            fetchReq.predicate = NSPredicate(format: "id = %@", idStr!)
            fetchReq.returnsObjectsAsFaults = false
            
            do {
                let results = try ctx.fetch(fetchReq)
                if results.count > 0 {
                    for res in results as! [NSManagedObject] {
                        if let name = res.value(forKey: "name") as? String {
                            nameField.text = name
                        }
                        if let artist = res.value(forKey: "artist") as? String {
                            artistField.text = artist
                        }
                        if let year = res.value(forKey: "year") as? Int32 {
                            yearField.text = String(year)
                        }
                        if let data = res.value(forKey: "image") as? Data {
                            let image = UIImage(data: data)
                            imageView.image = image
                        }
                    }
                }
            } catch {
                // Show alert
            }
            
        } else {
            // Do nothing
            saveButtonView.isHidden = false
            nameField.text = ""
            artistField.text = ""
            yearField.text = ""
        }

        // Recognizers
        let gestRec = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestRec)
        
        imageView.isUserInteractionEnabled = true
        let imageTapRec = UITapGestureRecognizer(target: self, action: #selector(selImage))
        imageView.addGestureRecognizer(imageTapRec)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func saveButton(_ sender: Any) {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let ctx = appDel.persistentContainer.viewContext
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: ctx)
        
        // Attributes
        newPainting.setValue(nameField.text!, forKey: "name")
        newPainting.setValue(artistField.text!, forKey: "artist")
        
        if let year = Int32(yearField.text!) {
            newPainting.setValue(year, forKey: "year")
        }
        
        newPainting.setValue(UUID(), forKey: "id")
        
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        newPainting.setValue(data, forKey: "image")
        
        do {
            try ctx.save()
        } catch {
            // Show alert
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func selImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.editedImage] as? UIImage
        saveButtonView.isEnabled = true
        self.dismiss(animated: true, completion: nil)
    }
    
}
