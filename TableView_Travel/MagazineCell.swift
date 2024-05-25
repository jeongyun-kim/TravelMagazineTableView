//
//  MagazineCell.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/25/24.
//

import UIKit
import Kingfisher

class MagazineCell: UITableViewCell {
    @IBOutlet var magazineDateLabel: UILabel!
    @IBOutlet var magazineSubTitleLabel: UILabel!
    @IBOutlet var magazineImageView: UIImageView!
    @IBOutlet var magazineTitleLabel: UILabel!
    
    func configure(title: String, subtitle: String, date: String, imageUrl: String) {
        magazineTitleLabel.text = title
        magazineTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        magazineTitleLabel.numberOfLines = 2
        
        magazineSubTitleLabel.text = subtitle
        magazineSubTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        magazineSubTitleLabel.textColor = .gray
    
        magazineDateLabel.text = date
        magazineDateLabel.textColor = .gray
        magazineDateLabel.font = UIFont.systemFont(ofSize: 14)
        
        let url = URL(string: imageUrl)
        magazineImageView.kf.setImage(with: url)
        magazineImageView.contentMode = .scaleAspectFill
        magazineImageView.layer.cornerRadius = 12
        
    }

}
