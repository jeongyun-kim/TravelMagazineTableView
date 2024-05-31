//
//  RestuarantViewController.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/26/24.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    @IBOutlet var searchBar: UISearchBar!
    
    var restaurantList = RestaurantList.restaurantArray
    
    var temp: [Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "식당 목록"
        setupSearchBar()
        setupTableView()
        temp = restaurantList
        let map = UIBarButtonItem(image: UIImage(systemName: "map.fill"), style: .plain, target: self, action: #selector(mapBtnTapped))
        navigationItem.rightBarButtonItem = map
    }
    
    func setupSearchBar() {
        searchBar.placeholder = "식당명, 카테고리, 주소로 검색해보세요"
        searchBar.delegate = self
    }
    
    func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temp.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as? RestaurantCell else { return UITableViewCell() }
        cell.configureCell(temp[indexPath.row])
        cell.likeBtn.tag = indexPath.row
        cell.likeBtn.addTarget(self, action: #selector(likeBtnTapped), for: .touchUpInside)
        return cell
    }
    
    @objc func mapBtnTapped(_ sender: UIButton) {
        let sb = UIStoryboard(name: "RestaurantMap", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: RestaurantMapViewController.identifier) as! RestaurantMapViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func likeBtnTapped(_ sender: UIButton) {
        temp[sender.tag].isLiked.toggle()
        // 원본 데이터에 현재 좋아요 누른 데이터의 인덱스 찾아서 좋아요 반영
        if let idx = restaurantList.firstIndex(where: { $0.name == temp[sender.tag].name}) {
            restaurantList[idx].isLiked.toggle()
        }
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
    
   
}

// 실시간 검색
extension RestaurantTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let keyword = searchBar.text else { return }
        if !keyword.isEmpty {
            let searchedDatas = restaurantList.filter {
                $0.name.contains(keyword) || $0.category.contains(keyword) || $0.address.contains(keyword)
            }
            temp = searchedDatas
        } else {
            view.endEditing(true)
            temp = restaurantList
        }
        tableView.reloadData()
    }
}
