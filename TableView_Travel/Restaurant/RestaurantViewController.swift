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

    var list = RestaurantList.restaurantArray
    let filteredDataList = RestaurantList.filteredDataDict // 카테고리별로 분류 된 데이터 [카테고리: [[식당 목록]]
    var result = RestaurantList.restaurantArray { // 테이블뷰 그릴 때 쓰일 데이터
        didSet {
            restaurantTableView.reloadData()
        }
    }
    // 필터링 목록 (= 전체보기, 한식, 양식 등)
    var filterList = RestaurantList.categoryList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupSearchController()
        [filterTableView, restaurantTableView].forEach { setupTableView($0) }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 페이지 올 때마다 '전체보기' 선택 중으로
        filterTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
    }
}

// MARK: UI
extension RestaurantViewController: setupUI {
    func setupNavigation() {
        navigationItem.title = "식당 목록"
        let map = UIBarButtonItem(image: UIImage(systemName: "map.fill"), style: .plain, target: self, action: #selector(mapBtnTapped))
        navigationItem.rightBarButtonItem = map
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
   
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
}

// MARK: Action
extension RestaurantViewController {
    @objc func mapBtnTapped(_ sender: UIButton) {
        let sb = UIStoryboard(name: "RestaurantMap", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: RestaurantMapViewController.identifier) as! RestaurantMapViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: TableViewExtension
extension RestaurantViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == filterTableView ? filterList.count : result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == filterTableView {
            guard let cell = filterTableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.identifier, for: indexPath) as? FilterTableViewCell else { return UITableViewCell() }
            cell.configureCell(filterList[indexPath.row])
            return cell
        } else {
            guard let cell = restaurantTableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.identifier, for: indexPath) as? RestaurantTableViewCell else { return UITableViewCell() }
            cell.configureCell(result[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == filterTableView {
            let key = filterList[indexPath.row]
            result = filteredDataList[key]!
        }
    }
}

// MARK: SearchBarExtension
extension RestaurantViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 현재 선택중인 카테고리의 row 값
        guard let row = filterTableView.indexPathForSelectedRow?.row else { return }
        guard let keyword = searchBar.text else { return }
        if keyword.isEmpty { // 검색어가 없다면 현재 선택중인 카테고리의 식당들 보여주기 
            let key = filterList[row]
            result = filteredDataList[key]!
        } else { // 검색 결과는 이름, 카테고리, 주소로 확인 
            result = result.filter {
                $0.nameAndCategory.contains(keyword) || $0.address.contains(keyword)
            }
        }
    }
}


