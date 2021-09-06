//
//  DetailsVC.swift
//  SimpsonsBook
//
//  Created by Logan Roth on 2020-12-21.
//

import UIKit

class DetailsVC: UIViewController {

    // Variables
    var selSimpson : Simpson?
    
    // Views
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nameLabel.text = selSimpson!.name
        jobLabel.text = selSimpson!.job.description
        imageView.image = selSimpson!.image
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
