//
//  ImageViewController.swift
//  LandmarkBook
//
//  Created by Logan Roth on 2020-12-20.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var landmarkLabel: UILabel!
    
    var selName = ""
    var selImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        landmarkLabel.text = selName
        image.image = selImage
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
