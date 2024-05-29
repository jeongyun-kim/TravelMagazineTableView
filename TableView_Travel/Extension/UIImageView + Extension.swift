//
//  UIImageView + Extension.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/27/24.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImageViewDesign() {
        self.layer.cornerRadius = 10
        self.contentMode = .scaleAspectFill
    }
    
    func setKingfisherImage(_ imageLink: String) {
        let url = URL(string: imageLink)
        self.kf.setImage(with: url)
    }
}
