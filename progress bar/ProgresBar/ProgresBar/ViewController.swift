//
//  ViewController.swift
//  ProgresBar
//
//  Created by Shannen Bravo-Brown on 6/7/18.
//  Copyright © 2018 Shannen Bravo-Brown. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDownloadDelegate {
    

    // lets draw a circle my using a ca shapel layer
    let shapeLayer = CAShapeLayer()
    
    //percentage in the middle
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(percentageLabel)
        percentageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        percentageLabel.center = view.center
        
        //path to draw it self
        
        //here is the code for the track layer
        let trackLayer = CAShapeLayer()
        //uiBezierPath
        let circlePath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        trackLayer.path = circlePath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.position = view.center
        view.layer.addSublayer(trackLayer)
        
        //get the tip of the stroke be curve
        shapeLayer.lineCap = kCALineCapRound
        
        // set the shapeslayers path
        shapeLayer.path = circlePath.cgPath
        
        //lets add a stroke color
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = 10
        
        //take away black circle
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        //get the tip of the stroke be curve
        shapeLayer.lineCap = kCALineCapRound
        
        //rotate layer
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2 , 0, 0, 1)
        
        //end stroke layer
        shapeLayer.strokeEnd = 0
        
        //add gesture so that when we tap the circle is animated
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        //set postion equal to the center
        shapeLayer.position = view.center
       
        //add sublayer to view
        view.layer.addSublayer(shapeLayer)
            
        }
    
    //THE URL WE ARE DOWNLOADING FROM
    let urlString = "https://firebasestorage.googleapis.com/v0/b/firestorechat-e64ac.appspot.com/o/intermediate_training_rec.mp4?alt=media&token=e20261d0-7219-49d2-b32d-367e1606500c"
    
    private func  beginDownLoadingFile(){
        shapeLayer.strokeEnd = 0
        //set defalt congif
        let configuration = URLSessionConfiguration.default
        //set url session
        //constrct operation queue
        let operationQueue = OperationQueue()
        let urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: operationQueue)
        
        //unwrap url string
        guard let url = URL(string: urlString) else { return }
        //down load task
        let downloadTask = urlSession.downloadTask(with: url)
        //download resume
        downloadTask.resume()
        
    }
    //helps us keep track of our download
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        //calculate percetage
        let percentage = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        
        //get back on the main ui thread
        DispatchQueue.main.async {
            self.percentageLabel.text = "\(Int(percentage * 100))%"
            self.shapeLayer.strokeEnd = CGFloat(percentage)
        }
        print(percentage)
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Finish Downloading")
    }

    @objc func handleTap(){
        beginDownLoadingFile()
//        //create a basic animation
//        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        //make the stroke end go to one
//        basicAnimation.toValue = 1
//
//        //set the duration
//        basicAnimation.duration = 2
//
//        //make endstroke stay
//        basicAnimation.fillMode = kCAFillModeForwards
//        basicAnimation.isRemovedOnCompletion = false
//
//        //add the basic animation
//        shapeLayer.add(basicAnimation, forKey: "WhatEver")
    }
    
        
}



