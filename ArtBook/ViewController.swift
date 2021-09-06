//
//  ViewController.swift
//  ArtBook
//
//  Created by Logan Roth on 2020-12-21.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Variables
    var chosenArt : String?
    var nameArray = [String]()
    var idArray = [UUID]()
    var selArtName = ""
    var selArt = UUID()

    // Views
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selArtName = nameArray[indexPath.row]
        selArt = idArray[indexPath.row]
        performSegue(withIdentifier: "toAddArt", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDel = UIApplication.shared.delegate as! AppDelegate
            let ctx = appDel.persistentContainer.viewContext
            
            let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            fetchReq.predicate = NSPredicate(format: "id = %@", idArray[indexPath.row].uuidString)
            fetchReq.returnsObjectsAsFaults = false
            
            do {
                let results = try ctx.fetch(fetchReq)
                if results.count > 0 {
                    for res in results as! [NSManagedObject] {
                        if let id = res.value(forKey: "id") as? UUID {
                            if id == idArray[indexPath.row] {
                                ctx.delete(res)
                                nameArray.remove(at: indexPath.row)
                                idArray.remove(at: indexPath.row)
                                self.tableView.reloadData()
                                do {
                                    try ctx.save()
                                } catch {
                                    // Show alert
                                }
                                break
                            }
                        }
                    }
                }
            } catch {
                // Show alert
            }
        }
    }
    
    @objc func getData() {
        nameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let ctx = appDel.persistentContainer.viewContext
        
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchReq.returnsObjectsAsFaults = false
        
        do {
            let results = try ctx.fetch(fetchReq)
            if results.count > 0 {
                for res in results as! [NSManagedObject] {
                    if let name = res.value(forKey: "name") as? String {
                        self.nameArray.append(name)
                    }
                    if let id = res.value(forKey: "id") as? UUID {
                        self.idArray.append(id)
                    }
                    self.tableView.reloadData()
                }
            }
        } catch {
            // Show alert
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddArt" {
            let destVC = segue.destination as! DetailsVC
            destVC.selArtName = selArtName
            destVC.selArt = selArt
        }
    }
    
    @objc func addButtonClicked() {
        selArtName = ""
        performSegue(withIdentifier: "toAddArt", sender: nil)
    }

}

