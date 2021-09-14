//
//  Extensions.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-12.
//

import Foundation
import UIKit

extension UIView {
    func makeCornersRound(cornerRadius: CGFloat, topLeft: Bool, topRight: Bool, bottomLeft: Bool, bottomRight: Bool) {
        var corners: CACornerMask = []
        
        if topLeft { corners.update(with: .layerMinXMinYCorner) }
        if topRight { corners.update(with: .layerMaxXMinYCorner) }
        if bottomLeft { corners.update(with: .layerMinXMaxYCorner) }
        if bottomRight { corners.update(with: .layerMaxXMaxYCorner) }
        
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = corners
    }
    
    func addBorder(borderColor: UIColor, borderWidth: CGFloat) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
    
    func makeRound() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.width/2
    }
}

extension UINavigationController {
    func getPreviousViewController() -> UIViewController? {
        let count = viewControllers.count
        guard count > 1 else { return nil }
        return viewControllers[count - 2]
    }
}

extension String {
    func getItemSize(font: UIFont) -> CGSize {
        let itemSize = self.size(withAttributes: [NSAttributedString.Key.font : font])
        return itemSize
    }
}

extension UILabel {
    func setLineHeight(lineHeight: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = self.textAlignment

        let attrString = NSMutableAttributedString()
        if (self.attributedText != nil) {
            attrString.append( self.attributedText!)
        } else {
            attrString.append( NSMutableAttributedString(string: self.text ?? ""))
            attrString.addAttribute(NSAttributedString.Key.font, value: self.font ?? UIFont.preferredFont(forTextStyle: .body), range: NSMakeRange(0, attrString.length))
        }
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        self.attributedText = attrString
    }
}
