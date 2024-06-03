//
//  PopularCityViewController.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/29/24.
//

import UIKit

// CaseIterable : allCases로 모든 케이스를 배열형태로 가져올 수 있음
enum listType: CaseIterable {
    case all
    case korean
    case foreign
    
    // 연산 프로퍼티
    var filteredList: [City] {
        switch self {
        case .all: return CityInfo.city
        case .korean: return CityInfo.korean
        case .foreign: return CityInfo.foreign
        }
    }
}

class PopularCityViewController: UIViewController {
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    
    let popularCityList = CityInfo.city
    let korean = CityInfo.korean
    let foreign = CityInfo.foreign
    
    lazy var searchKeyword: String = "" 
    
    var type: listType = .all
    
    var filteredCityList: [City] = CityInfo.city {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTableView()
        setupSegmentControl()
        setupSearchController()
    }
}

// MARK: 세그먼트 구성
extension PopularCityViewController {
    func setupSegmentControl() {
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)]
        // 선택된 세그먼트에는 폰트 굵게
        segmentControl.setTitleTextAttributes(attribute, for: .selected)
        
        let segmentTitles = ["모두", "국내", "해외"]
        let segmentActions = [popularCityList, korean, foreign]
        
        // enumerated()로 (인덱스값, 데이터) 모두 받아오기 가능
        for (idx, title) in segmentTitles.enumerated() {
            segmentControl.setTitle(title, forSegmentAt: idx)
            // 세그먼트 액션 구현 방법1) setAction
            //let action = UIAction { _ in self.filteredCityList = segmentActions[idx] }
            //segmentControl.setAction(action, forSegmentAt: idx)
        }
        
        // 세그먼트 액션 구현 방법 2) addTarget -> selectedSegmentIndex
        segmentControl.addTarget(self, action: #selector(segmentTapped), for: .valueChanged)
    }
    
    // enum의 allCases 활용해보기(0603)
    @objc func segmentTapped() {
        // 현재 세그먼트에서 선택한 인덱스 번호
        let selectedSegmentIdx = segmentControl.selectedSegmentIndex
        // listType을 allCases 형태로 가져와서 인덱스 번호로 해당 케이스가 반환해주는 리스트 가져오기 (모두/국내/해외)
        filteredCityList = listType.allCases[selectedSegmentIdx].filteredList
    }
}


extension PopularCityViewController: setupUI {
    func setupNavigation() {
        navigationItem.title = "인기도시"
    }

    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색어를 입력해주세요"
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let popularCityXib = UINib(nibName: PopularCityTableViewCell.identifier, bundle: nil)
        tableView.register(popularCityXib, forCellReuseIdentifier: PopularCityTableViewCell.identifier)
        // 폰 스크린 높이의 0.2를 높이로
        tableView.rowHeight = UIScreen.main.bounds.height * 0.2
        tableView.separatorStyle = .none
    }
}

// MARK: 테이블뷰
extension PopularCityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularCityTableViewCell.identifier, for: indexPath) as? PopularCityTableViewCell else { return UITableViewCell() }
        cell.configureCell(filteredCityList[indexPath.row])
        cell.addAttribute(searchKeyword)
        return cell
    }
    
}


// MARK: 검색 구현
extension PopularCityViewController: UISearchBarDelegate {
    func search(_ searchBar: UISearchBar) {
        // 서치바의 검색어
        guard let keyword = searchBar.text else { return }
        
        // 세그먼트 인덱스에 따라 다른 데이터로(모두/국내/해외)
        // 현재 세그먼트에서 선택한 인덱스 번호
        let selectedSegmentIdx = segmentControl.selectedSegmentIndex
        // listType을 allCases 형태로 가져와서 인덱스 번호로 해당 케이스가 반환해주는 리스트 가져오기 (모두/국내/해외)
        filteredCityList = listType.allCases[selectedSegmentIdx].filteredList
    
        // 소문자 처리한 검색어가 공백을 제거했을 때, 1글자 이상이라면 검색 돌리기
        if keyword.lowercased().components(separatedBy: " ").joined().count > 0 {
            let result = filteredCityList.filter {
                $0.cityName.lowercased().contains(keyword.lowercased())
                || $0.city_explain.contains(keyword)
            }
            if !result.isEmpty { // 검색결과가 존재한다면 원래 있던 검색어에 대치해주기
                searchKeyword = keyword.lowercased()
            }
            filteredCityList = result
        } else { // 검색어가 없다면 저장해둔 검색어 리셋
            searchKeyword = ""
        }
    }
    
    // 실시간 검색
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(searchBar)
    }
    
    // 검색 눌렀을 때
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(searchBar)
    }
}
