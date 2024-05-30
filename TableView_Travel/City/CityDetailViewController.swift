//
//  CityDetailViewController.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/29/24.
//

import UIKit

class CityDetailViewController: UIViewController {
    @IBOutlet var descLabel: UILabel!
    
    static let vcIdentifier = "CityDetailViewController"
    
    var data: Travel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        descLabel.text = data?.desc
        // 구조체로 정의한 폰트 스타일 불러오기 : 폰트크기 14
        descLabel.font = fontStyle.descFont
        descLabel.textColor = .lightGray
        descLabel.numberOfLines = 0
    }
    
    func setupNavigation() {
        navigationItem.title = data?.title
    }
    
    
}
