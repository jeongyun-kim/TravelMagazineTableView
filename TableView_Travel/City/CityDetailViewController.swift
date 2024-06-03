//
//  CityDetailViewController.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/29/24.
//

import UIKit

enum ViewType: String {
    case ad = "광고 화면"
    case city // ad에는 RawValue가 있지만 city는 없으므로 city의 RawValue는 city
}

class CityDetailViewController: UIViewController {
    @IBOutlet var descLabel: UILabel!
    
    var data: Travel?
    var type: ViewType = .city
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()
        print("DetailViewLoaded")
    }
    
    func setupUI() {
        descLabel.setDescLabel()
        descLabel.numberOfLines = 0
        switch type {
        case .ad:
            descLabel.text = type.rawValue
            view.backgroundColor = data?.bgColor
            descLabel.textColor = .black
        case .city:
            descLabel.text = data?.desc
        }
    }
    
    func setupNavigation() {
        navigationItem.title = data?.title
    }
}
