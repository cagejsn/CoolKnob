//
//  CoolScrollKnobView.swift
//  CoolScrollKnob
//
//  Created by Cage Johnson on 9/6/17.
//  Copyright © 2017 desk. All rights reserved.
//

import Foundation
import UIKit


class CoolScrollKnobView: UIView {
    
    var settingAsFloat: CGFloat = 0
    var radius: CGFloat!
    var panGR: UIPanGestureRecognizer!
    var previousTranslation: CGPoint!
    var square: UIView!
    
    func handlePan(sender: UIPanGestureRecognizer){
        
        if(sender.state == .ended){
            previousTranslation = nil
            return
        }
        
        if(sender.state == .began){
            settingAsFloat = 0
            if(previousTranslation == nil){
                previousTranslation = sender.translation(in: self)
                return
            }
        }
        
        if(sender.state == .changed){
            var vec = CGVector(dx: sender.translation(in: self).x - previousTranslation.x, dy: sender.translation(in: self).y - previousTranslation.y)
            var loc = sender.location(in: self)
            rotateSquare(by:  convertPanToRadian(location: loc, delta: vec))
            previousTranslation = sender.translation(in: self)
            print(settingAsFloat)
            
            
            if(settingAsFloat <= 0){
                print("oh no")
                settingAsFloat = 6.28318
            }
            
            if(settingAsFloat > 6.28318){
                print("yay")
                settingAsFloat = 0
            }
        }
    }
    
    func convertPanToRadian(location: CGPoint, delta: CGVector) -> CGFloat {
        //abs distance from circle center
        var distance: Float = hypotf(Float(location.x - self.center.x), Float(location.y - self.center.y));
        //this value is in iOS coords, with y values switched
        var locationRelativeToCircleCenter = location - self.center
       
        var cartesianLocation = CGPoint(x: locationRelativeToCircleCenter.x, y: -locationRelativeToCircleCenter.y)
        var cartesianDelta = CGVector(dx:delta.dx,dy:-delta.dy)
        
        //vector multiplication
        var dotProduct = (cartesianLocation.x * cartesianDelta.dx) + (cartesianLocation.y * cartesianDelta.dy)
        var scalar = dotProduct / CGFloat(distance*distance)
        var projAontoB = CGPoint(x: cartesianLocation.x * scalar, y: cartesianLocation.y * scalar)
        
        var deltaAsCGPoint = CGPoint(x: cartesianDelta.dx, y: cartesianDelta.dy)
        //takes the component of delta which is normal to distance vector
        var deltaNormalToDistance = deltaAsCGPoint - projAontoB
        var absOfDelta = hypotf(Float(deltaNormalToDistance.x), Float(deltaNormalToDistance.y))
        var newDelta: Float = 0
        
        //switch statement to find if rad should be positive or negative
        switch (cartesianLocation.x,cartesianLocation.y,deltaNormalToDistance.x,deltaNormalToDistance.y) {
        case let (cX,cY,dX,dY) where cX > 0 && cY > 0 && dX < 0 && dY > 0:
            newDelta = -absOfDelta
            break
        case let (cX,cY,dX,dY) where cX > 0 && cY > 0 && dX > 0 && dY < 0:
            newDelta = absOfDelta
            break
        case let (cX,cY,dX,dY) where cX > 0 && cY < 0 && dX > 0 && dY > 0:
            newDelta = -absOfDelta
            break
        case let (cX,cY,dX,dY) where cX > 0 && cY < 0 && dX < 0 && dY < 0:
            newDelta = absOfDelta
            break
        case let (cX,cY,dX,dY) where cX < 0 && cY < 0 && dX > 0 && dY < 0:
            newDelta = -absOfDelta
            break
        case let (cX,cY,dX,dY) where cX < 0 && cY < 0 && dX < 0 && dY > 0:
            newDelta = absOfDelta
            break
        case let (cX,cY,dX,dY) where cX < 0 && cY > 0 && dX < 0 && dY < 0:
            newDelta = -absOfDelta
            break
        case let (cX,cY,dX,dY) where cX < 0 && cY > 0 && dX > 0 && dY > 0:
            newDelta = absOfDelta
            break
        default:
            break
        }
        var rad = newDelta/distance
        return CGFloat(rad)
    }
    
    
    func drawCircle(){
        
        radius = (self.frame.width/2)
        var size = CGSize(width: radius, height: radius)
        var circle = CAShapeLayer(layer: layer)
        circle.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.width), byRoundingCorners: UIRectCorner.allCorners, cornerRadii:  size).cgPath
        circle.position = CGPoint.zero
        circle.fillColor = UIColor.blue.cgColor
        circle.strokeColor = UIColor.black.cgColor
        circle.lineWidth = 3
        
        self.layer.addSublayer(circle)
    }
    
    func drawSmallerCircle(){
        
    }
    
    func rotateSquare(by rad: CGFloat){
        
        square.transform = square.transform.rotated(by: rad)
        
        
    }
    
    func setUpVisual(){
        drawCircle()
        square = UIView(frame: self.frame)
        square.backgroundColor = UIColor.black
        square.alpha = 0.5
        self.addSubview(square)
        
        
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        panGR = UIPanGestureRecognizer(target: self, action: #selector(CoolScrollKnobView.handlePan(sender:)))
        self.addGestureRecognizer(panGR)
        setUpVisual()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
