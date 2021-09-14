//
//  AppUtils.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-12.
//

import Foundation
import UIKit

class AppUtils {
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    // Show Progress Indicator
    static func showProgressIndicator(view:UIView) {
        view.isUserInteractionEnabled = false
        
        // Create and add the view to the screen
        let progressIndicator = ProgressIndicator(text: ConstantData.message)
        progressIndicator.tag = ConstantData.PROGRESS_INDICATOR_VIEW_TAG
        view.addSubview(progressIndicator)
    }
    
    // Hide progress Indicator
    static func hideProgressIndicator(view:UIView) {
        
        view.isUserInteractionEnabled = true
        
        if let viewWithTag = view.viewWithTag(ConstantData.PROGRESS_INDICATOR_VIEW_TAG) {
            viewWithTag.removeFromSuperview()
        }
    }
}


