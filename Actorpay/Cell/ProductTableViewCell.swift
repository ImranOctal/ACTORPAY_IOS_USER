//
//  ProductTableViewCell.swift
//  Actorpay
//
//  Created by iMac on 06/12/21.
//

import UIKit
import SDWebImage

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var buyNowButton: UIButton!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var dealPriceLabel: UILabel!
    @IBOutlet weak var actualPriceLabel: UILabel!
    
    var item: Items? {
        didSet {
            let totalGst = (item?.cgst ?? 0) + (item?.sgst ?? 0)
            let totalPrice = totalGst + (item?.dealPrice ?? 0)
            if let item = self.item {
                titleLabel.text = item.name
                descriptionLabel.text = item.description
                if let url = URL(string: item.image ?? "") {
//                    print(url)
                    iconImage.sd_setImage(with: url,placeholderImage: UIImage(named: "placeholder_img"), completed: nil)
                } else{
                    iconImage.image = UIImage(named: "placeholder_img")
                }
                dealPriceLabel.text = "$\(totalPrice.doubleToStringWithComma())"
                actualPriceLabel.text = (item.actualPrice ?? 0).doubleToStringWithComma()
            } else{
                iconImage.image = UIImage(named: "placeholder_img")
            }
        }
    }
    
    var cartItemDtoList: CartItemDTOList?
    var buyNowButtonHandler: (() -> ())!
    var addToCartButtonHandler: (() -> ())!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func buyNowButtonAction(_ sender: UIButton){
        buyNowButtonHandler()
    }
    
    @IBAction func addTocartButtonAction(_ sender: UIButton){
        addToCartButtonHandler()
    }

}
