//
//  RestaurantViewController.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/31/24.
//

import UIKit

class RestaurantViewController: UIViewController {
    @IBOutlet var filterTableView: UITableView!
    @IBOutlet var restaurantTableView: UITableView!
    
    let list = RestaurantList.restaurantArray
    var filteredDataList = RestaurantList.restaurantArray {
        didSet {
            restaurantTableView.reloadData()
        }
    }
    
    var filterList = ["전체보기"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        [filterTableView, restaurantTableView].forEach { setupTableView($0) }
        filterList.append(contentsOf: RestaurantList().categoryList)
    }
}

extension RestaurantViewController: setupUI {
    func setupNavigation() {
        navigationItem.title = "식당 목록"
    }
    
    func setupTableView(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        let identifier = tableView == filterTableView ? FilterTableViewCell.identifier : RestaurantTableViewCell.identifier
        let xib = UINib(nibName: identifier, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
   

}

extension RestaurantViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == filterTableView ? filterList.count : filteredDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == filterTableView {
            guard let cell = filterTableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.identifier, for: indexPath) as? FilterTableViewCell else { return UITableViewCell() }
            cell.configureCell(filterList[indexPath.row])
            return cell
        } else {
            guard let cell = restaurantTableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.identifier, for: indexPath) as? RestaurantTableViewCell else { return UITableViewCell() }
            cell.configureCell(filteredDataList[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == filterTableView {
            getFilteredData(indexPath.row)
        }
    }
    
    func getFilteredData(_ row: Int) {
        let category = filterList[row]
        switch row {
        case 0: filteredDataList = list
        default: filteredDataList = list.filter { $0.category == category}
        }
    }
}

