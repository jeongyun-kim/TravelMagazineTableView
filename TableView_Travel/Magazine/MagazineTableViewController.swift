//
//  MagazineTableViewController.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/28/24.
//

import UIKit
import SafariServices

class MagazineTableViewController: UITableViewController {

    var magazineList: [Magazine] = MagazineInfo().magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "SeSAC TRAVEL"
        setupTableView()
    }
    
    func setupTableView() {
        // 테이블뷰 내 셀의 높이를 콘텐츠의 크기에 맞게 자동으로 조절
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        // 셀 간 구분선 없애기
        tableView.separatorStyle = .none
    }
}


// MARK: TableView
extension MagazineTableViewController {
    // 테이블뷰에 들어갈 셀의 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazineList.count
    }
    
    // cell 구성
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MagazineCell.identifier, for: indexPath) as? MagazineCell else { return UITableViewCell() }
        cell.configureCell(magazineList[indexPath.row])
        return cell
    }
    
    // 각 셀 탭했을 때 해당 링크(사파리) 띄우기
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: magazineList[indexPath.row].link) else { return }
        let safari = SFSafariViewController(url: url)
        present(safari, animated: true)
    }
}
