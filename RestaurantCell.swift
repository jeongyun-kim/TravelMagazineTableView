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

    func configure(imageLink: String, name: String, phonenumber: String, address: String, category: String, isLiked: Bool) {
        let url = URL(string: imageLink)
        thumbnailImageView.kf.setImage(with: url)
        thumbnailImageView.layer.cornerRadius = 10
        thumbnailImageView.contentMode = .scaleAspectFill
        
        nameLabel.text = name
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        phonenumberLabel.text = phonenumber
        phonenumberLabel.font = UIFont.systemFont(ofSize: 14)
        phonenumberLabel.textColor = .lightGray
        
        addressLabel.text = address
        addressLabel.font = UIFont.systemFont(ofSize: 14)
        addressLabel.textColor = .lightGray
        addressLabel.numberOfLines = 0
        
        categoryBtn.setAttributedTitle(NSAttributedString(string: category, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray.cgColor]), for: .normal)
        categoryBtn.isEnabled = false
        categoryBtn.backgroundColor = .systemGray6
        categoryBtn.layer.cornerRadius = 8
        
        let likeImage = isLiked ? "heart.fill" : "heart"
        likeBtn.setImage(UIImage(systemName: likeImage), for: .normal)
        likeBtn.setTitle("", for: .normal)
        likeBtn.tintColor = .systemPink
    }
}
