//
//  TravelTableViewController.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/25/24.
//

import UIKit

class TravelTableViewController: UITableViewController {

    var magazineList: [Magazine] = MagazineInfo().magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 450
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazineList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MagazineCell", for: indexPath) as? MagazineCell else { return UITableViewCell() }
        let magazine = magazineList[indexPath.row]
        cell.configure(title: magazine.title, subtitle: magazine.subtitle, date: magazine.date, imageUrl: magazine.photo_image)
        return cell
    }
}
