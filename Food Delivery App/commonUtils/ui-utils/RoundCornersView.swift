//
//  RoundCornersView.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-13.
//

import UIKit

class RoundCornersView: UIView {
    
    @IBInspectable var topLeft          : Bool       = false
    @IBInspectable var topRight         : Bool       = false
    @IBInspectable var bottomLeft       : Bool       = false
    @IBInspectable var bottomRight      : Bool       = false
    @IBInspectable var cornerRadius     : CGFloat    = 0 { didSet { setup() } }
    
    @IBInspectable var makeRound        : Bool       = false { didSet { setup() } }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    fileprivate func setup() {
        if cornerRadius > 0 {
            var corners: CACornerMask = []
            
            if topLeft { corners.update(with: .layerMinXMinYCorner) }
            if topRight { corners.update(with: .layerMaxXMinYCorner) }
            if bottomLeft { corners.update(with: .layerMinXMaxYCorner) }
            if bottomRight { corners.update(with: .layerMaxXMaxYCorner) }
            
            clipsToBounds = true
            layer.cornerRadius = cornerRadius
            layer.maskedCorners = corners
        }
        
        if makeRound {
            clipsToBounds = true
            layer.cornerRadius = frame.width/2
        }
    }
}

class RoundCornersImageView: UIImageView {
    
    @IBInspectable var topLeft          : Bool       = false
    @IBInspectable var topRight         : Bool       = false
    @IBInspectable var bottomLeft       : Bool       = false
    @IBInspectable var bottomRight      : Bool       = false
    @IBInspectable var cornerRadius     : CGFloat    = 0 { didSet { setup() } }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    fileprivate func setup() {
        var corners: CACornerMask = []
        
        if topLeft { corners.update(with: .layerMinXMinYCorner) }
        if topRight { corners.update(with: .layerMaxXMinYCorner) }
        if bottomLeft { corners.update(with: .layerMinXMaxYCorner) }
        if bottomRight { corners.update(with: .layerMaxXMaxYCorner) }
        
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = corners
        
    }
}
