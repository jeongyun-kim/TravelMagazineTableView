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
        selectionStyle = .none
        
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
    
    // 특별히 무언가를 적용한 셀을 재사용할 때, 해당 적용사항을 지워줘~
    // 지금같은 경우에는 광고 이전 셀은 구분선을 지워주고 있고 그 외는 다시 그려줘야 함
    // => 셀 재사용 시 구분선 지운거 취소하고 그려줘!
    override func prepareForReuse() {
        super.prepareForReuse()
        self.showSeparator()
    }
    
    func configureCell(_ data: Travel, toHideSeparatorCells: [Int], row: Int) {
        titleLabel.text = data.title
        // 옵셔널인 프로퍼티들 처리
        if let desc = data.description, let save = data.save, let imageLink = data.travel_image, let like = data.like, let grade = data.grade {
            descLabel.text = desc
            
            saveLabel.text = " · 저장 \(save.formatted())"
            
            thumbnailImageView.setKingfisherImage(imageLink)
            
            let likeImage = like ? "heart.fill" : "heart"
            
            likeBtn.setImage(UIImage(systemName: likeImage), for: .normal)
            
            fillStars(limit: data.roundedGrade)
        }
        // 광고 이전 셀이라면 아래 구분선 지우기
        if toHideSeparatorCells.contains(row) {
            self.hideSeparator()
        }
        
    }
    
    // ✏️ 별 그려주는건 cosmos 라이브러리를 이용해볼수도 있음 (완)
    func fillStars(limit: Int) {
        for i in (0..<5) {
            if i < limit {
                starImageViewCollection[i].tintColor = .systemYellow
            } else {
                starImageViewCollection[i].tintColor = .systemGray5
            }
        }
    }
}
