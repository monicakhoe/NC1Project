//
//  ViewController.swift
//  NC1 Project
//
//  Created by Monica Khoe on 17/05/19.
//  Copyright © 2019 Monica Khoe. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    
    @IBOutlet weak var roundButton: UIView!
   
    var pulseLayers = [CAShapeLayer]()
    var audioPlayer: AVAudioPlayer?
    
    @IBAction func roundButton(_ sender: UIButton) {
        
        playSound()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        roundButton.layer.masksToBounds = true
        roundButton.layer.cornerRadius = roundButton.frame.width/2
        createPulse()
    }

    func createPulse() {
        for _ in 0 ... 2{
            let circularPath = UIBezierPath(arcCenter: .zero, radius: UIScreen.main.bounds.size.width/2, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
             let pulseLayer = CAShapeLayer()
            pulseLayer.path = circularPath.cgPath
            pulseLayer.lineWidth = 0
            pulseLayer.fillColor = UIColor.clear.cgColor
            pulseLayer.strokeColor = UIColor.red.cgColor
            pulseLayer.lineCap = CAShapeLayerLineCap.round
            pulseLayer.position = CGPoint(x: roundButton.frame.size.width/2, y: roundButton.frame.size.width/2)
            roundButton.layer.addSublayer(pulseLayer)
            pulseLayers.append(pulseLayer)
        }
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.animatePulse(index: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.animatePulse(index: 1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    self.animatePulse(index: 2)
                }
            }
        }

    }
    
    func animatePulse(index: Int) {
        pulseLayers[index].strokeColor = UIColor.red.cgColor
        pulseLayers[index].fillColor = UIColor.red.cgColor
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 2.0
        scaleAnimation.fromValue = 0.3
        scaleAnimation.toValue = 0.9
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        scaleAnimation.repeatCount = .greatestFiniteMagnitude
        pulseLayers[index].add(scaleAnimation, forKey: "scale")

        let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        opacityAnimation.duration = 2.0
        opacityAnimation.fromValue = 0.9
        opacityAnimation.toValue = 0.0
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        opacityAnimation.repeatCount = .greatestFiniteMagnitude
        pulseLayers[index].add(opacityAnimation, forKey: "opacity")
        
    }
    
    func playSound() {
        
        let url = Bundle.main.url(forResource: "<#T##String?#>", withExtension: "<#T##String?#>")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            guard let player = audioPlayer else { return }
            
            audioPlayer.prepareToPlay()
            audioPlayer.delegate = self
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
            
            soundPlayed = true
        }
        
    }
    
}

