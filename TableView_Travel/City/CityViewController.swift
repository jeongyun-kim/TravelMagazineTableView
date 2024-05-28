//
//  CityViewController.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/27/24.
//

import UIKit

class CityViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var cityList = TravelInfo().travel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        navigationItem.title = "도시"
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let cityXIB = UINib(nibName: "CityCell", bundle: nil)
        tableView.register(cityXIB, forCellReuseIdentifier: "CityCell")
        let adXIB = UINib(nibName: "AdCell", bundle: nil)
        tableView.register(adXIB, forCellReuseIdentifier: "AdCell")
    }
    
    // 광고 이전 셀의 아래 구분선을 지워주기 위해 광고 이전 셀의 인덱스 값 가져오기
    func checkToHideSeparatorIdx() -> [Int] {
        var idxs: [Int] = []
        for (idx, city) in cityList.enumerated() {
            if city.ad {
                idxs.append(idx-1)
            }
        }
        return idxs
    }
    
    @objc func likeBtnTapped(_ sender: UIButton) {
        cityList[sender.tag].like?.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
}

extension CityViewController: UITableViewDelegate, UITableViewDataSource {
    // 광고인지 아닌지에 따른 셀의 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let isAd = cityList[indexPath.row].ad
        if isAd {
            return 95
        } else {
            return 140
        }
    }
    
    // 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    // 광고인지 아닌지에 따른 셀 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = cityList[indexPath.row]
        let cellIdentifier = data.ad ? AdCell.identifier : CityCell.identifier
        
        if data.ad {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AdCell else { return UITableViewCell() }
            cell.configureCell(data)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CityCell else { return UITableViewCell() }
            // 타이틀, 설명, 별점, 저장횟수, 이미지 링크, 광고와 연결된 셀인지, 광고와 연결된 셀이면 해당 셀의 순번
            cell.configureCell(data, toHideSeparatorCells: checkToHideSeparatorIdx(), row: indexPath.row)
            
            cell.likeBtn.tag = indexPath.row
            cell.likeBtn.addTarget(self, action: #selector(likeBtnTapped), for: .touchUpInside)
            return cell
        }
    }
}


