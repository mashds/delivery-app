//
//  CartItemTVCell.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-13.
//

import UIKit

class CartItemTVCell: UITableViewCell {
    
    @IBOutlet weak var itemImg  : UIImageView!
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var priceLbl : UILabel!
    
    var callback : (()->Void)?
}

// IB Actions
extension CartItemTVCell {
    @IBAction func deleteBtnClicked(_ sender: UIButton) {
        callback?()
    }
}
