//
//  ViewController.swift
//  BullEye
//
//  Created by leeguoyu on 15/10/17.
//  Copyright © 2015年 Mosh. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    var currentValue = 0
    var targetValue = 0
    
    /// 总分
    var score = 0
    
    ///回合数
    var round = 1
    
    ///开始新一局
    func startNewRound(){
        
        //arc4random_uniform 用于取xx以内的数字
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    /**为target标签赋值*/
    func updateLabels(){
        
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //自定义slider
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, forState: .Normal)
        
        let thumbImageHighlited = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlited, forState: .Highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 13)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage!.resizableImageWithCapInsets(insets)
        slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        
        
        let trackRightImage = UIImage(named: "SliderTrackRight")
        let trackRightResizable = trackRightImage!.resizableImageWithCapInsets(insets)
        slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)

        startNewRound()
        updateLabels()
        
    }

    @IBAction func sliderMoved(slider: UISlider){
        
        //lroundf 用于取整数
        currentValue = lroundf(slider.value)

    }
    
    @IBAction func showAlert(){
        
        round += 1

        //abs 用于取绝对值
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
            
        } else if difference <= 5 {
            title = "You almost did it!"
            points += 50
            
        } else if difference <= 10 {
            title = "Pretty good!"
        } else {
            title = "Never give up, try again!"
        }
        
        let message = "Your score is \(points) points"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "OK", style: .Default,
                                   handler: {action in
                                            self.startNewRound()
                                            self.updateLabels()
                                            })
        
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
        
        score += points
    }
    
    @IBAction func startNewGame(){
        
        score = 0
        round = 1
        startNewRound()
        updateLabels()
        
    }
    
    @IBAction func crossfadeAnimation(){

        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.addAnimation(transition, forKey: nil)
        
    }
    
    @IBAction func startOverAlert(){
        
        let title = "Start New Game"
        let message = "Are you sure you want to clear the record and start over?"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alert.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: {action in
                                                                            self.crossfadeAnimation()
                                                                            self.startNewGame()
                                                                            })
        alert.addAction(OKAction)
        
        
        presentViewController(alert, animated: true, completion: nil)
    }

}

