//
//  CityAdViewController.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/29/24.
//

import UIKit

class CityAdViewController: UIViewController {
    static let vcIdentifier = "CityAdViewController"
    
    lazy var navigationTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    func setupNavigation() {
        navigationItem.title = navigationTitle
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissModal))
    }
    
    @objc func dismissModal(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
