//
//  PopularCityTableViewCell.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/29/24.
//

import UIKit
import Kingfisher

class PopularCityTableViewCell: UITableViewCell {
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
    
    func addAttribute(_ searchKeyword: String) {
        if let cityName = self.cityNameLabel.text, let cityExplain = self.cityExplainLabel.text {
            // 속성먹일 NSMutableAttributedString 정의
            let attributedCityName = NSMutableAttributedString(string: cityName)
            let attributedCityExplain = NSMutableAttributedString(string: cityExplain)
            // 검색어가 존재한다면 속성 넣어주기
            // 1. 각 label의 text를 소문자로 바꿔서 비교(검색어가 소문자니까!)하고 일치하는 범주에 속성(bakcgroundColor) 넣어주기
            // 2. 속성 적용
            if !searchKeyword.isEmpty {
                attributedCityName.addAttribute(.backgroundColor, value: UIColor.systemYellow, range: (cityName.lowercased() as NSString).range(of: searchKeyword))
                attributedCityExplain.addAttribute(.backgroundColor, value: UIColor.systemYellow, range: (cityExplain.lowercased() as NSString).range(of: searchKeyword))
                self.cityNameLabel.attributedText = attributedCityName
                self.cityExplainLabel.attributedText = attributedCityExplain
            } else {
                // 검색어가 없다면 속성먹인것들 모두 제거 
                [attributedCityName, attributedCityExplain].forEach { attributedStr in
                    attributedStr.removeAttribute(NSAttributedString.Key.backgroundColor, range: NSMakeRange(0, attributedStr.length))
                }
            }
        }
    }
}
