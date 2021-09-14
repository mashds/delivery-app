//
//  CustomButton.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-13.
//

import UIKit

class CustomButton: UIButton {
    
    @IBInspectable var topLeft          : Bool       = false
    @IBInspectable var topRight         : Bool       = false
    @IBInspectable var bottomLeft       : Bool       = false
    @IBInspectable var bottomRight      : Bool       = false
    @IBInspectable var cornerRadius     : CGFloat    = 0 { didSet { setup() } }
    
    @IBInspectable var makeRound        : Bool       = false { didSet { setup() } }
    
    @IBInspectable var topInsets        : CGFloat    = 0
    @IBInspectable var leftInsets       : CGFloat    = 0
    @IBInspectable var bottomInsets     : CGFloat    = 0
    @IBInspectable var rightInsets      : CGFloat    = 0
    
    @IBInspectable var borderColor      : UIColor    = UIColor.clear
    @IBInspectable var borderWidth      : CGFloat    = 0
    
    @IBInspectable var topImageInsets   : CGFloat    = 0
    @IBInspectable var leftImageInsets  : CGFloat    = 0
    @IBInspectable var bottomImageInsets: CGFloat    = 0
    @IBInspectable var rightImageInsets : CGFloat    = 0 { didSet { setup() } }
    
    @IBInspectable var shadowColor      : UIColor    = UIColor.clear
    
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
        
        contentEdgeInsets = UIEdgeInsets(top: topInsets, left: leftInsets, bottom: bottomInsets, right: rightInsets)
        
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        
        imageEdgeInsets = UIEdgeInsets(top: topImageInsets, left: leftImageInsets, bottom: bottomImageInsets, right: rightImageInsets)
        
        if shadowColor != UIColor.clear {
            layer.masksToBounds = false
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOpacity = 1.0
            layer.shadowRadius = 1
            layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        }
        
        if makeRound {
            clipsToBounds = true
            layer.cornerRadius = frame.width/2
        }
    }
}
