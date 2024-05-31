//
//  RestuarantCell.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/26/24.
//

import UIKit
import Kingfisher

class RestaurantCell: UITableViewCell {
    @IBOutlet var likeBtn: UIButton!
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var phonenumberLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var categoryBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }
    
    func configureLayout() {
        thumbnailImageView.setImageViewDesign()
        
        nameLabel.setTitleLabel(size: 15)
        
        phonenumberLabel.setDescLabel()
        
        addressLabel.setDescLabel(size: 13)
        addressLabel.numberOfLines = 0
    
        categoryBtn.isEnabled = false
        categoryBtn.backgroundColor = .systemGray6
        categoryBtn.layer.cornerRadius = 8
        
        likeBtn.tintColor = .systemPink
    }
    
    func configureCell(_ data: Restaurant) {
        thumbnailImageView.setKingfisherImage(data.image)
        
        nameLabel.text = data.name
        
        phonenumberLabel.text = data.phoneNumber
        
        addressLabel.text = data.address
        
        categoryBtn.setAttributedTitle(NSAttributedString(string: data.category, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray.cgColor]), for: .normal)
        
        let likeImage = data.isLiked ? "heart.fill" : "heart"
        likeBtn.setImage(UIImage(systemName: likeImage), for: .normal)
        likeBtn.setTitle("", for: .normal)
    }
}
