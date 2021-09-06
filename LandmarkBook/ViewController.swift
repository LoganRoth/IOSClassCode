//
//  ViewController.swift
//  LandmarkBook
//
//  Created by Logan Roth on 2020-12-20.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var landmarkNames = [String]()
    var landmarkImages = [UIImage]()
    var chosenName = ""
    var chosenImage = UIImage()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        landmarkNames.append("Colosseum")
        landmarkNames.append("Great Wall of China")
        landmarkNames.append("Kremlin")
        landmarkNames.append("Taj Mahal")
        landmarkNames.append("Stonehenge")
        
        landmarkImages.append(UIImage(named:"col.jpg")!)
        landmarkImages.append(UIImage(named:"gwc.jpg")!)
        landmarkImages.append(UIImage(named:"krem.jpg")!)
        landmarkImages.append(UIImage(named:"taj.jpg")!)
        landmarkImages.append(UIImage(named:"sh.jpg")!)
        
        navigationItem.title = "Landmark Book"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landmarkNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = landmarkNames[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            landmarkNames.remove(at: indexPath.row)
            landmarkImages.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenName = landmarkNames[indexPath.row]
        chosenImage = landmarkImages[indexPath.row]
        
        performSegue(withIdentifier: "toImageVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toImageVC" {
            let destVC = segue.destination as! ImageViewController
            destVC.selImage = chosenImage
            destVC.selName = chosenName
        }
    }
}

