//
//  Resources.swift
//  TableView_Travel
//
//  Created by 김정윤 on 6/19/24.
//

import Foundation

enum FoodCategory: String, CaseIterable {
    case all = "전체보기"
    case korean = "한식"
    case japanes = "일식"
    case chinese = "중식"
    case western = "양식"
    
    var restauranList: [Restaurant] {
        switch self {
        case .all:
            return RestaurantList.restaurantArray
        case .korean, .japanes, .chinese, .western:
            return RestaurantList.restaurantArray.filter { $0.category == self.rawValue }
        }
    }
}

enum LocationCase {
    static let userLocation = "내 위치"
    static let alertTitle = "위치 서비스 사용"
    static let alertMessage = #"위치서비스를 사용할 수 없습니다\#n기기의 "설정 > 개인 정보 보호"에서 위치 서비스를 켜주세요"#
    static let settingActionTitle = "설정으로 이동"
    static let cancel = "취소"
}
