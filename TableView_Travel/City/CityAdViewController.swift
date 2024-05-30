//
//  CityAdViewController.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/29/24.
//

import UIKit

class CityAdViewController: UIViewController {
    static let vcIdentifier = "CityAdViewController"
    
    var data: Travel?
    lazy var color: UIColor = .clear
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        view.backgroundColor = color
    }

    
    @objc func dismissModal(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

extension CityAdViewController: setupUI {
    func setupNavigation() {
        navigationItem.title = data?.title
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissModal))
    }
}
