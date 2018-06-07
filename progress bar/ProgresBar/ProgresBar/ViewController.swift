//
//  ViewController.swift
//  ProgresBar
//
//  Created by Shannen Bravo-Brown on 6/7/18.
//  Copyright © 2018 Shannen Bravo-Brown. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // lets draw a circle my using a ca shapel layer
    let shapeLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //path to draw it self
        //set the circles center
        let center = view.center
        
        //here is the scode for the track layer
        let trackLayer = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        trackLayer.path = circlePath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(trackLayer)
        
        //get the tip of the stroke be curve
        shapeLayer.lineCap = kCALineCapRound
        //uiBezierPath
//        let circlePath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        // set the shapeslayers path
        shapeLayer.path = circlePath.cgPath
        
        //lets add a stroke color
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = 10
        
        //take away black circle
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        //get the tip of the stroke be curve
        shapeLayer.lineCap = kCALineCapRound
        
        //end stroke layer
        shapeLayer.strokeEnd = 0
        
        //add gesture so that when we tap the circle is animated
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        //add sublayer to view
        view.layer.addSublayer(shapeLayer)
            
        }
    @objc func handleTap(){
        
        //create a basic animation
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        //make the stroke end go to one
        basicAnimation.toValue = 1
        
        //set the duration
        basicAnimation.duration = 2
        
        //make endstroke stay
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        
        //add the basic animation
        shapeLayer.add(basicAnimation, forKey: "WhatEver")
    }
    
        
}



