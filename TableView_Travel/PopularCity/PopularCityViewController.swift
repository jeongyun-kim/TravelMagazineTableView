//
//  PopularCityViewController.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/29/24.
//

import UIKit

class PopularCityViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    let popularCityList = CityInfo.city
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let popularCityXib = UINib(nibName: PopularCityTableViewCell.identifier, bundle: nil)
        tableView.register(popularCityXib, forCellReuseIdentifier: PopularCityTableViewCell.identifier)
        tableView.rowHeight = 200
        //tableView.estimatedRowHeight = UITableView.automaticDimension
    }
}

extension PopularCityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularCityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularCityTableViewCell.identifier, for: indexPath) as? PopularCityTableViewCell else { return UITableViewCell() }
        cell.configureCell(popularCityList[indexPath.row])
        return cell
    }
}
