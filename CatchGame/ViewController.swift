//
//  ViewController.swift
//  CatchGame
//
//  Created by Taylan Deniz Polat on 31.07.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var timer = Timer()
    var time = 10
    var width = 0
    var height = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        imageViewProcess()
        labelProcesss()
        startGame()      
    }
    
    func labelProcesss(){
        let x = Int(self.view.frame.minX) + 25
        let h = height - 50
        timeLabel.frame = CGRect(x : x, y: h, width: 150, height: 50)
        scoreLabel.frame = CGRect(x : x, y: h - 25, width: 150, height: 50)
    }
    
    func imageViewProcess(){
        width = Int(self.view.frame.maxX)
        height = Int(self.view.frame.maxY)
        
        imageView.frame =
            CGRect(x : self.view.frame.midX, y: self.view.frame.midY, width: 50, height: 50)
        imageView.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(scoreCounter))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func scoreCounter(){
        score = score + 1
    }
    
    func startGame(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(game), userInfo: nil, repeats: true)
    }
    
    func finishGame(){
        timer.invalidate()
        alertMessage()
    }
    
    @objc func game(){
        let x = Int.random(in: 0..<width - 50)
        let h = Int.random(in: Int(self.view.frame.minY) + 50..<height - 125)
        imageView.frame = CGRect(x : x, y: h, width: 50, height: 50)
        time = time - 1
        timeLabel.text = "Time : \(time)"
        scoreLabel.text = "Score : \(score)"
        if time == 0 {
            finishGame()
        }
    }
 
    func alertMessage(){
        let alert = UIAlertController(title: "Finish", message: "Again ?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let againAction = UIAlertAction(title: "Again", style: .default) { UIAlertAction in
            self.score = 0
            self.time = 10
            self.startGame()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(againAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

