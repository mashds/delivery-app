//
//  LoadImage.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-12.
//

import Foundation
import UIKit
import Nuke

/*
 
 HOW TO USE :
 
 LoadImage.init(urlString: "", imageView: self.imageView).execute()
 
 */

class LoadImage {
    
    var basedURL = ""
    
    var urlString   : String?
    var imageView   : UIImageView?
    
    init(urlString:String, imageView:UIImageView) {
        let escapedString = urlString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        self.urlString = escapedString
        self.imageView = imageView
    }
    
    // Set image to a given image view with caching
    func execute() {
        
        let request = ImageRequest(urlRequest: URLRequest(url: URL(string: urlString!)!))
        Nuke.loadImage(with: request, into: imageView!)
        
    }
    
}
