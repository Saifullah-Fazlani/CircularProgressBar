//
//  ViewController.swift
//  CircularProgressView
//
//  Created by Saifullah Fazlani on 17/10/2019.
//  Copyright © 2019 Saifullah Fazlani. All rights reserved.
//

import UIKit

class CircularProgressBar: UIViewController
{
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var lblValue: UILabel!
    
    @IBOutlet weak var tfMinValue: UITextField!
    @IBOutlet weak var tfMaxValue: UITextField!
    @IBOutlet weak var btnAnimate: UIButton!
    
    let trackLayer = CAShapeLayer()
    let shapeLayer = CAShapeLayer()
    let outerLayer = CAShapeLayer()
    let innerLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onBtnAnimate(_ sender: Any) {
        let min = Int(tfMinValue.text ?? "0") ?? 0
        let minValue = CGFloat(exactly: min) ?? 0.0
        
        let max = Int(tfMaxValue.text ?? "0") ?? 0
        let maxValue = CGFloat(exactly: max) ?? 0.0
        
        makeProgressView(containerView: progressView, width: 5, minValue: minValue, maxValue: maxValue)
    }
    
    func makeProgressView(containerView: UIView, width: CGFloat, minValue: CGFloat, maxValue: CGFloat) {
    
        let radius = (containerView.frame.width / 2) - 5
        let widthDiff = width / 2
        let percent = minValue / maxValue
        let percentage = percent * 100
        let completeAngle = 2 * CGFloat.pi
        let calculatedAngle = CGFloat.pi * 2 * percent - CGFloat.pi / 2
        let basicAnim = CABasicAnimation(keyPath: "strokeEnd")
        let viewCenter = CGPoint(x: containerView.bounds.midX, y: containerView.bounds.midY)
        
        trackLayer.path = makePath(arcCenter: viewCenter, radius: radius, endAngle: completeAngle).cgPath
        shapeLayer.path = makePath(arcCenter: viewCenter, radius: radius, endAngle: calculatedAngle).cgPath
        outerLayer.path = makePath(arcCenter: viewCenter, radius: radius + widthDiff, endAngle: completeAngle).cgPath
        innerLayer.path = makePath(arcCenter: viewCenter, radius: radius - widthDiff, endAngle: completeAngle).cgPath
        
        trackLayer.strokeColor = UIColor.white.cgColor
        trackLayer.lineWidth = width
        trackLayer.lineCap = CAShapeLayerLineCap.square
        trackLayer.fillColor = UIColor.clear.cgColor
        
        shapeLayer.strokeColor = getProgressColor(percentage: percentage)
        shapeLayer.lineWidth = width
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = CAShapeLayerLineCap.square
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        outerLayer.strokeColor = getProgressColor(percentage: percentage)
        outerLayer.lineWidth = 0.1 * width
        outerLayer.lineCap = CAShapeLayerLineCap.square
        outerLayer.fillColor = UIColor.clear.cgColor
        
        innerLayer.strokeColor = getProgressColor(percentage: percentage)
        innerLayer.lineWidth = 0.1 * width
        innerLayer.lineCap = CAShapeLayerLineCap.square
        innerLayer.fillColor = UIColor.clear.cgColor
        
        containerView.layer.addSublayer(trackLayer)
        containerView.layer.addSublayer(shapeLayer)
        containerView.layer.addSublayer(outerLayer)
        containerView.layer.addSublayer(innerLayer)
        
        basicAnim.toValue = 1
        basicAnim.duration = 1
        basicAnim.fillMode = CAMediaTimingFillMode.forwards
        basicAnim.isRemovedOnCompletion = false
        shapeLayer.add(basicAnim, forKey: "Blah")
        
        lblValue.text = "\(percentage)%"
        
    }
    
    func makePath(arcCenter: CGPoint, radius: CGFloat, endAngle: CGFloat ) -> UIBezierPath {
        return UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: -CGFloat.pi/2, endAngle: endAngle, clockwise: true)
    }
    
    func getProgressColor(percentage: CGFloat) -> CGColor {
        
        switch percentage {
            
            case _ where percentage < 25:
                return UIColor.red.cgColor
            case _ where percentage >= 25 && percentage < 75:
                return UIColor.yellow.cgColor
            case _ where percentage >= 75:
                return UIColor.green.cgColor
            default:
                return UIColor.clear.cgColor
            
        }
        
    }
    
}

