//
//  RestuarantViewController.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/26/24.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    @IBOutlet var searchBar: UISearchBar!
    
    var restaurantList = RestaurantList().restaurantArray.map {
        RestaurantData(image: $0.image, latitude: $0.latitude, longitude: $0.longitude, name: $0.name, address: $0.address, phoneNumber: $0.phoneNumber, category: $0.category, price: $0.price, type: $0.type, isLiked: false)
    }
    var temp: [RestaurantData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setupUI()
        temp = restaurantList
    }

    func setupUI() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        navigationItem.title = "식당 목록"
        
        searchBar.placeholder = "식당명, 카테고리, 주소로 검색해보세요"
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temp.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as? RestaurantCell else { return UITableViewCell() }
        let data = temp[indexPath.row]
        
        cell.configureCell(imageLink: data.image, name: data.name, phonenumber: data.phoneNumber, address: data.address, category: data.category, isLiked: data.isLiked)
        
        cell.likeBtn.tag = indexPath.row
        cell.likeBtn.addTarget(self, action: #selector(likeBtnTapped), for: .touchUpInside)
        
        return cell
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
