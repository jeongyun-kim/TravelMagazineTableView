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
}

class PopularCityViewController: UIViewController {
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!

    private let vm = PopularCityViewModel()
    
    private var searchKeyword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTableView()
        setupSegmentControl()
        setupSearchController()
        bind()
        vm.inputCitySegmentIdx.value = segmentControl.selectedSegmentIndex
    }
}

// MARK: 세그먼트 구성
extension PopularCityViewController {
    func setupSegmentControl() {
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)]
        // 선택된 세그먼트에는 폰트 굵게
        segmentControl.setTitleTextAttributes(attribute, for: .selected)
        let segmentTitles = ["모두", "국내", "해외"]
        
        // enumerated()로 (인덱스값, 데이터) 모두 받아오기 가능
        for (idx, title) in segmentTitles.enumerated() {
            segmentControl.setTitle(title, forSegmentAt: idx)
        }
        
        segmentControl.addTarget(self, action: #selector(segmentTapped), for: .valueChanged)
    }
    
    @objc func segmentTapped() {
        // 현재 세그먼트에서 선택한 인덱스 번호 ViewModel로 전달
        vm.inputCitySegmentIdx.value = segmentControl.selectedSegmentIndex
    }
    
    private func bind() {
        // outputFilteredCityList가 변경될 때마다 테이블뷰 다시 그리기
        vm.outputFilteredCityList.bind { cityList in
            self.tableView.reloadData()
        }
        
        vm.outputValidateSearchResult.bind { result in
            if result { // 검색결과가 존재한다면 이전 검색어를 현재 검색어로 변경해주기
                self.searchKeyword = self.vm.inputSearchKeyword.value
            }
        }
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
        return vm.outputFilteredCityList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularCityTableViewCell.identifier, for: indexPath) as? PopularCityTableViewCell else { return UITableViewCell() }
        let data = vm.outputFilteredCityList.value[indexPath.row]
        cell.configureCell(data)
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
        // ViewModel에 현재 선택중인 인덱스 번호 전달해줘 검색어가 바뀔 때마다 필터링 된 데이터 가져오기
        vm.inputCitySegmentIdx.value = segmentControl.selectedSegmentIndex
    
        // 소문자 처리한 검색어가 공백을 제거했을 때, 1글자 이상이라면 ViewModel로 해당 키워드 보내기
        if keyword.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 {
            vm.inputSearchKeyword.value = keyword.lowercased()
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
