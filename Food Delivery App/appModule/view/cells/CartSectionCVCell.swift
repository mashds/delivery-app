//
//  CartSectionCVCell.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-13.
//

import UIKit

class CartSectionCVCell: UICollectionViewCell {
    
    @IBOutlet weak var cellTitle      : UILabel!
    
    private lazy var widthConstraint = contentView.widthAnchor.constraint(equalToConstant: 0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.cellTitle.textColor = UIColor.black
            } else {
                self.cellTitle.textColor = UIColor.lightGray
            }
        }
    }
    
}
