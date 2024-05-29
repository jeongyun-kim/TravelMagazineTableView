//
//  CityDetailViewController.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/29/24.
//

import UIKit

class CityDetailViewController: UIViewController {
    static let vcIdentifier = "CityDetailViewController"
    
    lazy var navigationTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = navigationTitle
    }
    
}
