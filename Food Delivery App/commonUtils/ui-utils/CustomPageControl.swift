//
//  CustomPageControl.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-14.
//

import Foundation
import UIKit

class CustomPageControl: UIPageControl {
    override var currentPage: Int { didSet { updateDots() } }
    
    func updateDots() {
        let currentDot = subviews[currentPage]
        let largeScaling = CGAffineTransform(scaleX: 3, y: 3)
        
        subviews[0].subviews[0].subviews.forEach {
            // Apply the large scale of newly selected dot.
            // Restore the small scale of previously selected dot.
            $0.transform = $0 == currentDot ? largeScaling : .identity
        }
//        subviews.forEach($0.transform = $0 == currentDot ? largeScaling : .identity)
    }
}
