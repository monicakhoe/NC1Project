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
    var beginPlayer: AVAudioPlayer?
    var run_animation = true
    
    @IBOutlet weak var jumpScareImage: UIImageView!
    
    @IBAction func roundButton(_ sender: UIButton) {
        
//        playSound(rate: 1)
//        run_animation = false
//        UIView.animate(withDuration: 10) {
//            self.roundButton.transform = CGAffineTransform(scaleX: 2, y: 2)
//        }
////        audioPlayer?.setVolume(1, fadeDuration: 2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openingSound(isPlay: false)
        jumpScareImage.isHidden = true
        roundButton.layer.cornerRadius = roundButton.frame.width/2
        createPulse()
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleGesture))
        longPress.minimumPressDuration = 0.5
        longPress.delaysTouchesBegan = true
        longPress.delegate = self as? UIGestureRecognizerDelegate
        self.roundButton.addGestureRecognizer(longPress)
        
//        roundButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }

//    @objc func longPressAction(){
//        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction))
//        self.view.addGestureRecognizer(longPress)
//
//        playSound()
//        run_animation = false
//        UIView.animate(withDuration: 10) {
//            self.roundButton.transform = CGAffineTransform(scaleX: 2, y: 2)
//        }
//    }
    
    
    
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
        
        if run_animation == true {
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
    
    
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("done")
    }
    
    func playSound(rate:Float) {
        
        if audioPlayer == nil {
            
            guard let url = Bundle.main.url(forResource: "footsteps1", withExtension: "mp3")
                else { return }
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.enableRate = true
                audioPlayer?.rate = rate
                audioPlayer?.prepareToPlay()
            } catch let error {
                print(error.localizedDescription)
            }
            
            Timer.scheduledTimer(withTimeInterval: 5.5, repeats: false) { _ in
                
//                self.audioPlayer?.stop()
//
//                guard let url = Bundle.main.url(forResource: "footsteps1", withExtension: "mp3")
//                    else { return }
//
//                do {
//                    self.audioPlayer = try AVAudioPlayer(contentsOf: url)
//                    self.audioPlayer?.numberOfLoops = -1
//                    self.audioPlayer?.enableRate = true
                    self.audioPlayer?.rate = 2
//                    self.audioPlayer?.prepareToPlay()
//                    self.audioPlayer?.play()
//                } catch let error {
//                    print(error.localizedDescription)
//                }
            }
        }
        audioPlayer?.play()
//        audioPlayer?.stop()
        
    }
   // var enableRate: Bool { get set }
    
    func playSound2() {
        guard let url = Bundle.main.url(forResource: "Creaking Door 1", withExtension: "mp3")
            else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
        } catch let error {
            print(error.localizedDescription)
        }
        audioPlayer?.play()
    }
    
    func playSound3() {
        guard let url = Bundle.main.url(forResource: "Scream", withExtension: "mp3")
            else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
        } catch let error {
            print(error.localizedDescription)
        }
        audioPlayer?.play()
    }
    
    func openingSound(isPlay: Bool) {
        guard let url = Bundle.main.url(forResource: "Opening", withExtension: "mp3")
            else { return }
        
        do {
            beginPlayer = try AVAudioPlayer(contentsOf: url)
            beginPlayer?.prepareToPlay()
            beginPlayer?.numberOfLoops = -1
        } catch let error {
            print(error.localizedDescription)
        }
        
        if isPlay == true {
            self.beginPlayer?.stop()
        } else if isPlay == false{
            self.beginPlayer?.play()
        }
        
        
    }
    
    
    var normalRate = 1.0
    
    @IBAction func handleGesture(_ sender: UILongPressGestureRecognizer) {
        
        if sender.state == .began{
            openingSound(isPlay: true)
            pulseLayers[0].isHidden = true
            pulseLayers[1].isHidden = true
            pulseLayers[2].isHidden = true
            run_animation = false
//            openingSound(isPlay: false)
            playSound(rate: 1)
            
            
            let currentWidth = roundButton.frame.width
            
            UIView.animate(withDuration: 10, animations: {
                self.roundButton.transform = CGAffineTransform(scaleX: 3, y: 3)
                self.roundButton.backgroundColor = UIColor(displayP3Red: 1, green: 0, blue: 0, alpha: 1)
            }) { (finish) in
                if self.roundButton.frame.width == (currentWidth*3) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                        self.audioPlayer?.stop()
                        self.roundButton.isHidden = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            self.playSound2()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                self.playSound3()
                                UIView.animate(withDuration: 1, animations: {
                                    self.jumpScareImage.isHidden = false
                                    self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                                    UIView.animate(withDuration: 0.0001, animations: {
                                        self.jumpScareImage.alpha = 1
                                        self.jumpScareImage.transform = .init(scaleX: 5, y: 5)
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5){
                                            UIView.animate(withDuration: 0.0001, animations: {
                                                self.jumpScareImage.alpha = 0
                                                self.jumpScareImage.transform = .init(scaleX: 0, y: 0)
                                            })
                                        }
                                    })
                                })
                            }
                        }
                    }
                }
                

            }
        }
        if sender.state == .ended {
            pulseLayers[0].isHidden = false
            pulseLayers[1].isHidden = false
            pulseLayers[2].isHidden = false
            run_animation = false
//            playSound()
            audioPlayer?.stop()
            UIView.animate(withDuration: 5) {
                self.roundButton.transform = .identity
                self.roundButton.backgroundColor = UIColor.white

                
            }
        }
        
//        if sender.state == .changed{
//            print("hello")
//            playSound(rate: Float(normalRate - 0.01))
//        }
    }
    
    
}

