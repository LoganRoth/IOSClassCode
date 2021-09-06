//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by Logan Roth on 2020-12-15.
//

import UIKit

class ViewController: UIViewController {

    // Variables
    var score = 0
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    var kenArr = [UIImageView]()
    var highscore = 0
    
    // Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    @IBOutlet weak var kenny10: UIImageView!
    @IBOutlet weak var kenny11: UIImageView!
    @IBOutlet weak var kenny12: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: \(score)"
        
        // Highscore check
        let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighscore == nil {
            highscore = 0
        } else {
            if let newScore = storedHighscore as? Int {
                highscore = newScore
            } else {
                highscore = 0
            }
        }
        highscoreLabel.text = "Highscore: \(highscore)"
        
        
        // Images
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        kenny10.isUserInteractionEnabled = true
        kenny11.isUserInteractionEnabled = true
        kenny12.isUserInteractionEnabled = true
        
        let rec1 = UITapGestureRecognizer(target: self, action: #selector(incScore))
        let rec2 = UITapGestureRecognizer(target: self, action: #selector(incScore))
        let rec3 = UITapGestureRecognizer(target: self, action: #selector(incScore))
        let rec4 = UITapGestureRecognizer(target: self, action: #selector(incScore))
        let rec5 = UITapGestureRecognizer(target: self, action: #selector(incScore))
        let rec6 = UITapGestureRecognizer(target: self, action: #selector(incScore))
        let rec7 = UITapGestureRecognizer(target: self, action: #selector(incScore))
        let rec8 = UITapGestureRecognizer(target: self, action: #selector(incScore))
        let rec9 = UITapGestureRecognizer(target: self, action: #selector(incScore))
        let rec10 = UITapGestureRecognizer(target: self, action: #selector(incScore))
        let rec11 = UITapGestureRecognizer(target: self, action: #selector(incScore))
        let rec12 = UITapGestureRecognizer(target: self, action: #selector(incScore))
        
        kenny1.addGestureRecognizer(rec1)
        kenny2.addGestureRecognizer(rec2)
        kenny3.addGestureRecognizer(rec3)
        kenny4.addGestureRecognizer(rec4)
        kenny5.addGestureRecognizer(rec5)
        kenny6.addGestureRecognizer(rec6)
        kenny7.addGestureRecognizer(rec7)
        kenny8.addGestureRecognizer(rec8)
        kenny9.addGestureRecognizer(rec9)
        kenny10.addGestureRecognizer(rec10)
        kenny11.addGestureRecognizer(rec11)
        kenny12.addGestureRecognizer(rec12)
        
        kenArr = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9, kenny10, kenny11, kenny12]
        
        hideKenny()
        
        // Timers
        counter = 30
        timeLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
    }
    
    @objc func incScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
        
    }
    
    @objc func countDown() {
        counter -= 1
        timeLabel.text = "\(counter)"
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            timeLabel.text = "Game Over!"
            for kenny in kenArr {
                kenny.isHidden = true
            }
            
            // Highscore
            if self.score < self.highscore {
                self.highscore = self.score
                self.highscoreLabel.text = "Highscore: \(self.highscore)"
                UserDefaults.standard.set(self.highscore, forKey: "highscore")
            }
            
            // Alert
            let alert = UIAlertController(title: "Game Over", message: "Want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.cancel) {
                (UIAlertAction) in
                // Replay Function
                self.score = 0
                self.counter = 30
                self.scoreLabel.text = "Score: \(self.score)"
                self.timeLabel.text = "\(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func hideKenny() {
        for kenny in kenArr {
            kenny.isHidden = true
        }
        let showKen = Int(arc4random_uniform(UInt32(kenArr.count - 1)))
        kenArr[showKen].isHidden = false
    }


}

