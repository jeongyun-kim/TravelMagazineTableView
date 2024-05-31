//
//  City+CosmosCell.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/28/24.
//

import UIKit
import Cosmos
import Kingfisher

// cosmos 이용해서 별점 넣어보기 (완) 
class City_CosmosCell: UITableViewCell {
    @IBOutlet var likeBtn: UIButton!
    @IBOutlet var citySaveLabel: UILabel!
    @IBOutlet var cityRateView: CosmosView!
    @IBOutlet var cityDescLabel: UILabel!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var cityImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureLayout()
    }

    func configureLayout() {
        cityImageView.setImageViewDesign()
        
        cityNameLabel.setTitleLabel(size: 15)
        
        cityDescLabel.setDescLabel()
        
        citySaveLabel.setDescLabel(size: 12)
        
        likeBtn.setTitle("", for: .normal)
        likeBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        likeBtn.tintColor = .white
        
        cityRateView.settings.fillMode = .precise
        cityRateView.settings.starSize = 12
        // 별 간격
        cityRateView.settings.starMargin = 0
        // 채워졌을 때 배경색
        cityRateView.settings.filledColor = .systemYellow
        // 비어있을 때 배경색
        cityRateView.settings.emptyColor = .systemGray6
        // 채워졌을 때 선의 색상
        cityRateView.settings.filledBorderColor = .systemYellow
        // 비어있을 때 선의 색상
        cityRateView.settings.emptyBorderColor = .systemGray6
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.showSeparator()
    }
    
    func configureCell(_ data: Travel, toHideSeparatorCells: [Int], row: Int) {
        cityNameLabel.text = data.title
        // 옵셔널인 프로퍼티들 처리
        if let desc = data.description, let save = data.save, let imageLink = data.travel_image, let like = data.like, let grade = data.grade {
            cityDescLabel.text = desc
            
            citySaveLabel.text = " · 저장 \(save.formatted())"
            
            cityImageView.setKingfisherImage(imageLink)
            
            let likeImage = like ? "heart.fill" : "heart"
            likeBtn.setImage(UIImage(systemName: likeImage), for: .normal)
            
            cityRateView.rating = grade
        }
        // 광고 이전 셀이라면 아래 구분선 지우기
        if toHideSeparatorCells.contains(row) {
            self.hideSeparator()
        }
    }
}
