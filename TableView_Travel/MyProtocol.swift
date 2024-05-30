//
//  MyProtocol.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/30/24.
//

import Foundation

@objc protocol setupUI {
    func setupNavigation()
    @objc optional func setupTableView()
    @objc optional func setupSearchController()
}
