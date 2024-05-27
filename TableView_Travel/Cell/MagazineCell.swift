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
        magazineTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        magazineTitleLabel.numberOfLines = 2
        
        magazineSubTitleLabel.text = subtitle
        magazineSubTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        magazineSubTitleLabel.textColor = .gray
    
        magazineDateLabel.text = dateFormat(dateString: date)
        magazineDateLabel.textColor = .gray
        magazineDateLabel.font = UIFont.systemFont(ofSize: 13)
        
        let url = URL(string: imageUrl)
        magazineImageView.kf.setImage(with: url)
        magazineImageView.contentMode = .scaleAspectFill
        magazineImageView.layer.cornerRadius = 12
    }
    
    // DateFormatter 이용한 날짜 변환
    func dateFormat(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        // 받아온 날짜의 형식
        dateFormatter.dateFormat = "yyMMdd"
        // String으로 받아온 날짜를 Date로 변환
        guard let date = dateFormatter.date(from: dateString) else { return "" }
        // 변환한 Date를 String으로 변경할 때의 형식
        dateFormatter.dateFormat = "yy년 M월 d일"
        // Date를 String으로 변환 후 return
        return dateFormatter.string(from: date)
    }

}
