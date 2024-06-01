//
//  MyProtocol.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/30/24.
//

import UIKit

@objc protocol setupUI {
    func setupNavigation()
    @objc optional func setupTableView()
    @objc optional func setupSearchController()
}

protocol ReusableIdentifier {
    static var identifier: String { get }
}

extension UITableViewCell: ReusableIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController: ReusableIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}


