//
//  ViewController.swift
//  FaceIt
//
//  Created by Leonardo Lombardi on 7/13/16.
//  Copyright © 2016 Uruzilla. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
    var expression = FacialExpression(eyes: .Open, eyeBrows: .Relaxed, mouth: .Smile){
        didSet {
            updateUI()
        }
    }
    @IBOutlet weak var faceView: FaceView!{
        didSet {
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(FaceView.changeScale(_:))))
            updateUI()
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

