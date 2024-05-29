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
    
    @IBOutlet var cityExplainLabel: UILabel!
    @IBOutlet var cityExplainView: UIView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var cityImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }
    
    func configureLayout() {
        cityNameLabel.setTitleLabel(size: 20)
        cityNameLabel.textColor = .white
        
        
        cityExplainView.backgroundColor = .black.withAlphaComponent(0.6)
        
       
        cityImageView.contentMode = .scaleAspectFill
        cityImageView.setMaskedCorner(cornerRadius: 16, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMaxYCorner])
        
        cityExplainLabel.setDescLabel(color: .white)
        cityExplainView.setMaskedCorner(cornerRadius: 16, maskedCorners: [.layerMaxXMaxYCorner])
        
    }
    
    func configureCell(_ data: City) {
        cityNameLabel.text = data.cityName
        cityImageView.setKingfisherImage(data.city_image)
        cityExplainLabel.text = data.city_explain
    }
}
