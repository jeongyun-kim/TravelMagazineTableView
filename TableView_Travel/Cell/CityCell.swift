//
//  CityCellTableViewCell.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/27/24.
//

import UIKit
import Kingfisher

class CityCell: UITableViewCell {
    @IBOutlet var saveLabel: UILabel!
    @IBOutlet var starImageViewCollection: [UIImageView]!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var likeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }

    func configureLayout() {
        thumbnailImageView.setImageViewDesign()
        titleLabel.setTitleLabel(size: 15)
        descLabel.setDescLabel()
        saveLabel.setDescLabel(size: 12)
        // 별점 기본은 회색
        starImageViewCollection.forEach { imageView in
            imageView.image = UIImage(systemName: "star.fill")
            imageView.tintColor = .systemGray5
        }
        likeBtn.setTitle("", for: .normal)
        likeBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        likeBtn.tintColor = .white
    }
    
    func configureCell(title: String, desc: String, grade: Float, save: Int, image: String, isLike: Bool, toHideSeparatorCells: [Int], row: Int) {
        titleLabel.text = title
        descLabel.text = desc
        // 각 별점 반올림해서 별 색깔 칠해주기
        let limit = Int(round(grade))
        print(grade, limit)
        for i in (0..<5) {
            if i < limit {
                starImageViewCollection[i].tintColor = .systemYellow
            } else {
                starImageViewCollection[i].tintColor = .systemGray5
            }
        
        }
        saveLabel.text = " · 저장 \(save.formatted())"
        let url = URL(string: image)
        thumbnailImageView.kf.setImage(with: url)
        
        let likeImage = isLike ? "heart.fill" : "heart"
        likeBtn.setImage(UIImage(systemName: likeImage), for: .normal)
        
        // 광고 이전 셀이라면 아래 구분선 지우기
        if toHideSeparatorCells.contains(row) {
            self.hideSeparator()
        } else {
            self.showSeparator()
        }
    }
}
