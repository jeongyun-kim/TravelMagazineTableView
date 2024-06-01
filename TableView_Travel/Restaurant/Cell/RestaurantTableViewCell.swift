//
//  RestaurantTableViewCell.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/31/24.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    @IBOutlet var likeBtn: UIButton!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var phonenumberLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var restaurantImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }
    
    func configureLayout() {
        restaurantImageView.setImageViewDesign()
        
        nameLabel.setTitleLabel(size: 15)
        nameLabel.numberOfLines = 0
        
        phonenumberLabel.setDescLabel()
        
        addressLabel.setDescLabel(size: 13)
        addressLabel.numberOfLines = 0
        
        priceLabel.textColor = .lightGray
        priceLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    func configureCell(_ data: Restaurant) {
       restaurantImageView.setKingfisherImage(data.image)
        
        nameLabel.text = data.nameAndCategory
        
        phonenumberLabel.text = data.phoneNumber
        
        addressLabel.text = data.address
        
        priceLabel.text = "\(data.price.formatted())원~"
    }
}
