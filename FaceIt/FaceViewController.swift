//
//  ViewController.swift
//  FaceIt
//
//  Created by Leonardo Lombardi on 7/13/16.
//  Copyright © 2016 Uruzilla. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
    var expression = FacialExpression(eyes: .Open, eyeBrows: .Relaxed, mouth: .Frown ){
        didSet {
            updateUI()
        }
    }
    @IBOutlet weak var faceView: FaceView!{
        didSet {
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(FaceView.changeScale(_:))))
            let happierGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(increaseHappiness))
            happierGestureRecognizer.direction = .Up
            faceView.addGestureRecognizer(happierGestureRecognizer)
            let sadderGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(decreaseHappiness))
            sadderGestureRecognizer.direction = .Down
            faceView.addGestureRecognizer(sadderGestureRecognizer)
            
            updateUI()
        }
    }
    
    @objc private func increaseHappiness(){
        expression.mouth = expression.mouth.happierMouth()
    }
    
    @objc private func decreaseHappiness(){
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    @IBAction func toggleEyes(sender: UITapGestureRecognizer) {
        if sender.state == .Ended{
            switch expression.eyes {
            case .Open:
                expression.eyes = .Closed
            case .Closed:
                expression.eyes = .Open
            case .Squinting:
                expression.eyes = .Open
            }
        }
    }
    
    private var mouthCurvatures = [
        FacialExpression.Mouth.Frown:-1.0,
        .Grin:0.5,
        .Smile:1.0,
        .Neutral:0.0,
        .Smirk: -0.5]
    
    private var eyeBrownTilts = [FacialExpression.EyeBrows.Furrowed:-0.5, .Normal:0.0 , .Relaxed: 0.5]
    
    private func updateUI(){
        switch expression.eyes {
        case .Open:
            faceView.eyesOpen = true
        case .Closed:
            faceView.eyesOpen = false
        case .Squinting:
            faceView.eyesOpen = false
        }
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
        faceView.eyeBrowTilt = eyeBrownTilts[expression.eyeBrows] ?? 0.0
    }
    
}

