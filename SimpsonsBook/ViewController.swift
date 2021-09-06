//
//  ViewController.swift
//  SimpsonsBook
//
//  Created by Logan Roth on 2020-12-21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    // Variables
    var mySimpsons = [Simpson]()
    var chosenSimpson : Simpson?
    
    // Views
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        mySimpsons.append(Simpson(nameInit: "Homer", jobInit: .NuclearSafety, imageInit: UIImage(named: "homer.png")!))
        mySimpsons.append(Simpson(nameInit: "Marge", jobInit: .Mom, imageInit: UIImage(named: "marge.png")!))
        mySimpsons.append(Simpson(nameInit: "Lisa", jobInit: .Student, imageInit: UIImage(named: "lisa.png")!))
        mySimpsons.append(Simpson(nameInit: "Bart", jobInit: .Student, imageInit: UIImage(named: "bart.png")!))
        mySimpsons.append(Simpson(nameInit: "Maggie", jobInit: .Baby, imageInit: UIImage(named: "maggie.png")!))
    }
    
    // TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySimpsons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = mySimpsons[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenSimpson = mySimpsons[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destVC = segue.destination as! DetailsVC
            destVC.selSimpson = chosenSimpson
        }
    }
    

}

