//
//  RestuarantViewController.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/26/24.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    @IBOutlet var searchBtn: UIButton!
    @IBOutlet var searchTextField: UITextField!
    
    var restaurantList = RestaurantList().restaurantArray.map {
        RestaurantData(image: $0.image, latitude: $0.latitude, longitude: $0.longitude, name: $0.name, address: $0.address, phoneNumber: $0.phoneNumber, category: $0.category, price: $0.price, type: $0.type, isLiked: false)
    }
    var temp: [RestaurantData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        temp = restaurantList
    }

    func setupUI() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        navigationItem.title = "식당 목록"
        
        searchTextField.backgroundColor = .systemGray6
        searchTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        searchTextField.leftViewMode = .always
        searchTextField.attributedPlaceholder = NSAttributedString(string: "식당 이름, 카테고리를 검색해보세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.cgColor])
        searchTextField.borderStyle = .none
        searchTextField.layer.cornerRadius = 10
        
        searchBtn.setTitle("", for: .normal)
        searchBtn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchBtn.tintColor = .black
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as? RestaurantCell else { return UITableViewCell() }
        let data = restaurantList[indexPath.row]
        
        cell.configure(imageLink: data.image, name: data.name, phonenumber: data.phoneNumber, address: data.address, category: data.category, isLiked: data.isLiked)
        
        cell.likeBtn.tag = indexPath.row
        cell.likeBtn.addTarget(self, action: #selector(likeBtnTapped), for: .touchUpInside)
        
        return cell
    }
    
    @objc func likeBtnTapped(_ sender: UIButton) {
        restaurantList[sender.tag].isLiked.toggle()
        // 원본 데이터에 현재 좋아요 누른 데이터의 인덱스 찾아서 좋아요 반영
        let data = restaurantList[sender.tag]
        if let idx = temp.firstIndex(where: { $0.name == data.name}) {
            temp[idx].isLiked.toggle()
        }
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
    
    @IBAction func searchBtnTapped(_ sender: Any) {
        guard let keyword = searchTextField.text else { return }
        
        if !keyword.isEmpty {
            let searchedDatas = temp.filter {
                $0.name.contains(keyword) || $0.category.contains(keyword)
            }
            restaurantList = searchedDatas
        }
        view.endEditing(true)
        tableView.reloadData()
    }
    
    @IBAction func editingTextField(_ sender: UITextField) {
        guard let keyword = searchTextField.text else { return }
        if keyword.isEmpty {
            restaurantList = temp
        }
        tableView.reloadData()
    }
}

