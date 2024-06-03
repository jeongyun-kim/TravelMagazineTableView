//
//  CityAdViewController.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/29/24.
//

import UIKit

class CityAdViewController: UIViewController {
    var data: Travel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        view.backgroundColor = data?.bgColor
    }
}


// MARK: UI
extension CityAdViewController: setupUI {
    func setupNavigation() {
        navigationItem.title = data?.title
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissModal))
    }
}

// MARK: Action
extension CityAdViewController {
    @objc func dismissModal(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
