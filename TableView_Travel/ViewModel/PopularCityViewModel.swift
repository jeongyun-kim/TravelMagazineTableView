//
//  PopularCityViewModel.swift
//  TableView_Travel
//
//  Created by 김정윤 on 7/9/24.
//

import Foundation

final class PopularCityViewModel {
    private let allCityList = CityInfo.city
    
    // Input
    // segment를 누를 때마다 넣어줄 input값
    var inputCitySegmentIdx = Observable(value: 1)
    var inputSearchKeyword = Observable(value: "")
    
    // Output
    // 테이블뷰 그릴 때 사용되는 필터링 된 도시 리스트 / 검색결과 또한 포함
    var outputFilteredCityList: Observable<[City]> = Observable(value: [])
    // 검색결과가 있는지
    var outputValidateSearchResult: Observable<Bool> = Observable(value: false)
    
    init() {
        inputCitySegmentIdx.bind { idx in
            switch listType.allCases[idx] {
            case .all:
                self.outputFilteredCityList.value = self.allCityList
            case .korean:
                self.outputFilteredCityList.value = self.allCityList.filter { $0.domestic_travel == true }
            case .foreign:
                self.outputFilteredCityList.value = self.allCityList.filter { $0.domestic_travel == false }
            }
        }
        
        inputSearchKeyword.bind { keyword in
            // 현재 필터링 되어있는 여행지들 중에서 검색 돌리기
            let result = self.outputFilteredCityList.value.filter { city in
                city.cityName.lowercased().contains(keyword)
                || city.city_explain.contains(keyword)
            }
            // 검색어 저장을 위한 검색결과 유무 반환
            self.outputValidateSearchResult.value = result.count > 0
            // tableView 갱신을 위한 검색결과 반환
            self.outputFilteredCityList.value = result
        }
    }
}
