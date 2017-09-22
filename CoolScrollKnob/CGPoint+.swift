//
//  CGPoint+.swift
//  CoolScrollKnob
//
//  Created by Cage Johnson on 9/9/17.
//  Copyright © 2017 desk. All rights reserved.
//

import Foundation
import UIKit

extension CGPoint {
    static func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }    
    static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}
