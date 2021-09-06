//
//  SnapVC.swift
//  SnapchatClone
//
//  Created by Logan Roth on 2021-01-09.
//

import UIKit
import ImageSlideshow

class SnapVC: UIViewController {
    var selSnap : SnapModel?
    var inArr = [KingfisherSource]()

    @IBOutlet weak var timeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let time = selSnap?.timeLeft {
            timeLabel.text = "Time Left: \(time)"
        }
        
        if let snap = selSnap {
            for imageUrl in snap.imageUrlArray {
                inArr.append(KingfisherSource(urlString: imageUrl)!)
            }
            
            let imageSlide = ImageSlideshow(frame: CGRect(x: 10, y: 10, width: self.view.frame.width * 0.95, height: self.view.frame.height * 0.85))
            imageSlide.backgroundColor = UIColor.white
            
            let pageInd = UIPageControl()
            pageInd.currentPageIndicatorTintColor = UIColor.black
            pageInd.pageIndicatorTintColor = UIColor.lightGray
            imageSlide.pageIndicator = pageInd
            
            imageSlide.contentScaleMode = UIViewContentMode.scaleAspectFit
            imageSlide.setImageInputs(inArr)
            
            self.view.addSubview(imageSlide)
            self.view.bringSubviewToFront(timeLabel)
        }
        
        
    }
}
