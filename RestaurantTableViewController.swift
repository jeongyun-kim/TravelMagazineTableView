//
//  RestuarantViewController.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/26/24.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    let restaurantList = RestaurantList().restaurantArray.map {
        RestaurantData(image: $0.image, latitude: $0.latitude, longitude: $0.longitude, name: $0.name, address: $0.address, phoneNumber: $0.phoneNumber, category: $0.category, price: $0.price, type: $0.type, isLiked: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        navigationItem.title = "식당 목록"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as? RestaurantCell else { return UITableViewCell() }
        let data = restaurantList[indexPath.row]
        
        cell.configure(imageLink: data.image, name: data.name, phonenumber: data.phoneNumber, address: data.address, category: data.category, isLiked: data.isLiked)
        
        return cell
    }
}

