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
        setupNavigation()
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
}


// MARK: 네비게이션 및 테이블뷰 세팅
// setupUI 라는 프로토콜(네비게이션 세팅, 테이블뷰 세팅(옵셔녈)) 생성해서 사용해보기
extension CityViewController: setupUI {
    func setupNavigation() {
        navigationItem.backButtonTitle = ""
        navigationItem.title = "도시"
        navigationController?.navigationBar.tintColor = .black
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let cityXIB = UINib(nibName: CityCell.identifier, bundle: nil)
        tableView.register(cityXIB, forCellReuseIdentifier: CityCell.identifier)
        let adXIB = UINib(nibName: AdCell.identifier, bundle: nil)
        tableView.register(adXIB, forCellReuseIdentifier: AdCell.identifier)
    }
}

// MARK: Action
extension CityViewController {
    @objc func likeBtnTapped(_ sender: UIButton) {
        cityList[sender.tag].like?.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
}

// MARK: 테이블뷰 필수 메서드 구현 및 셀 선택 시의 화면전환
extension CityViewController: UITableViewDelegate, UITableViewDataSource {
    // 광고인지 아닌지에 따른 셀의 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cityList[indexPath.row].ad ? 95 : 140
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
    
    // 광고인지 아닌지에 따라 Present / Push => CityDetailViewController 재활용 및 enum 이용해서 광고인지 아닌지에 따라 present / push (0603)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = cityList[indexPath.row]
        let type = data.ad ? ViewType.ad : ViewType.city
        
        let sb = UIStoryboard(name: "CityDetail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: CityDetailViewController.identifier) as! CityDetailViewController
        vc.data = data
        vc.type = type
        switch type {
        case .ad:
            let navi = UINavigationController(rootViewController: vc)
            present(navi, animated: true)
        case .city:
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
