//
//  ItemTVCell.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-12.
//

import UIKit

class ItemTVCell: UITableViewCell {
    
    @IBOutlet weak var itemImg          : UIImageView!
    @IBOutlet weak var bottomView       : UIView!
    @IBOutlet weak var titleLbl         : UILabel!
    @IBOutlet weak var indicatorView    : UIView!
    @IBOutlet weak var descriptionLbl   : UILabel!
    @IBOutlet weak var addBtn           : UIButton!
    @IBOutlet weak var infoLbl          : UILabel!
    
    var callback : (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }    
}

// IB Actions
extension ItemTVCell {
    @IBAction func addBtnClicked(_ sender: UIButton) {
        let previousText = sender.titleLabel?.text
        
        // change the colors of the button
        UIView.animate(withDuration: 1.0, animations: {
            sender.backgroundColor = UIColor(named: "primary-green")
            sender.setTitle("added+1", for: .normal)
        }, completion: { (finished: Bool) in
            UIView.animate(withDuration: 1.0) {
                sender.backgroundColor = UIColor.black
                sender.setTitle(previousText, for: .normal)
            }
        })
        
        callback?()
    }
}
