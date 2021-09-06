//
//  ListViewController.swift
//  TravelBook
//
//  Created by Logan Roth on 2020-12-28.
//

import UIKit
import CoreData

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Variables
    var placeArr = [String]()
    var idArr = [UUID]()
    var chosenTitle = ""
    var chosenId : UUID?

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        getData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newPlace"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placeArr[indexPath.row]
        return cell
    }
    
    @objc func getData() {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let ctx = appDel.persistentContainer.viewContext
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "TaggedLocations")
        req.returnsObjectsAsFaults = false
        
        do {
            let results = try ctx.fetch(req)
            if results.count > 0 {
                self.placeArr.removeAll()
                self.idArr.removeAll()
                for result in results as! [NSManagedObject] {
                    if let title = result.value(forKey: "title") as? String {
                        placeArr.append(title)
                        
                    }
                    if let id = result.value(forKey: "id") as? UUID {
                        idArr.append(id)
                    }
                }
                tableView.reloadData()
            }
        } catch {
            // Show Alert
        }
    }
    
    @objc func addButtonClicked() {
        chosenTitle = ""
        performSegue(withIdentifier: "toVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenTitle = placeArr[indexPath.row]
        chosenId = idArr[indexPath.row]
        performSegue(withIdentifier: "toVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toVC" {
            let destVC = segue.destination as! ViewController
            destVC.selTitle = chosenTitle
            destVC.selId = chosenId
        }
    }

}
