//
//  RewardPointsTableViewCell.swift
//  Actorpay
//
//  Created by iMac on 06/12/21.
//

import UIKit

class RewardPointsTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var redeemButton: UIButton!
    @IBOutlet weak var iconImage: UIImageView!
    
    var redeemButtonHandler: (() -> ())!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func redeemButtonAction(_ sender: UIButton){
        redeemButtonHandler()
    }
    
}
