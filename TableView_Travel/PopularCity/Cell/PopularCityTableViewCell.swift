//
//  PopularCityTableViewCell.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/29/24.
//

import UIKit
import Kingfisher

class PopularCityTableViewCell: UITableViewCell {
    static let identifier = "PopularCityTableViewCell"
    
    @IBOutlet var cityView: UIView!
    @IBOutlet var cityExplainLabel: UILabel!
    @IBOutlet var cityExplainView: UIView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var cityImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }
    
    func configureLayout() {
        self.selectionStyle = .none
        
        cityNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        cityNameLabel.textColor = .white
        
        cityExplainView.backgroundColor = .black.withAlphaComponent(0.6)
        
        cityImageView.contentMode = .scaleAspectFill
        cityImageView.setMaskedCorner(cornerRadius: 16, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMaxYCorner])
    
        // 이미지 따라서 코너 깎고 뒤에 그림자 주기
        cityView.setMaskedCorner(cornerRadius: 16, maskedCorners: [.layerMaxXMaxYCorner])
        cityView.layer.masksToBounds = false
        cityView.layer.shadowOpacity = 0.2
        cityView.layer.shadowOffset = .init(width: 5, height: 5)
    
        cityExplainLabel.setDescLabel(color: .white)
        
        cityExplainView.setMaskedCorner(cornerRadius: 16, maskedCorners: [.layerMaxXMaxYCorner])
    }
    
    func configureCell(_ data: City) {
        cityNameLabel.text = data.cityName
        cityImageView.setKingfisherImage(data.city_image)
        cityExplainLabel.text = data.city_explain
    }
}
