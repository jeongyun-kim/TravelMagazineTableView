///
//  AdCell.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/27/24.
//

import UIKit

class AdCell: UITableViewCell {
    static let identifier = "AdCell"
    
    @IBOutlet var adView: UIView!
    @IBOutlet var adLabel: UILabel!
    @IBOutlet var adBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }

    func configureLayout() {
        adView.backgroundColor = getRandomColor()
        adView.layer.cornerRadius = 10
        
        adLabel.setTitleLabel(size: 15)
        
        adLabel.numberOfLines = 0
        adLabel.setLineSpacing(lineSpacing: 4)
        adLabel.textAlignment = .center
        
        adBtn.setTitle("AD", for: .normal)
        adBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        adBtn.tintColor = .black
        adBtn.backgroundColor = .white
        adBtn.layer.cornerRadius = 8
    }
    
    // 뷰가 그려지고 레이아웃이 그려진 이후에 뷰를 레이아웃에 맞게 업데이트 해야할 때
    override func layoutSubviews() {
        super.layoutSubviews()
        // 구분선 지우기
        self.hideSeparator()
    }
    
    func configureCell(_ data: Travel) {
        adLabel.text = data.title
    }
    
    func getRandomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0).withAlphaComponent(0.5)
        return color
    }
}
