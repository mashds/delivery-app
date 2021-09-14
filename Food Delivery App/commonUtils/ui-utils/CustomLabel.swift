//
//  CustomLabel.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-13.
//

import UIKit

class CustomLabel: UILabel {
    
    @IBInspectable var makeRound : Bool = false { didSet { setup() } }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    fileprivate func setup() {
        if makeRound {
            clipsToBounds = true
            layer.cornerRadius = frame.width/2
        }
    }
}
