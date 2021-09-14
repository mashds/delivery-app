//
//  ConstantData.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-12.
//

import Foundation
import UIKit

struct ConstantData {
    
    static var PROGRESS_INDICATOR_VIEW_TAG: Int = 10
    static var message = "Please Wait"
    
    static var rowValue = 6 // Loading animation type
    static var size = CGSize(width: 35, height: 35) // Loading animation size
    
    static let black2 = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.9)
    
}

enum Category {
    case pizza
    case pasta
    case sides
}
