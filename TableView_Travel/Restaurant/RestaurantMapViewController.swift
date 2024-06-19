//
//  RestaurantMapViewController.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/30/24.
//

import UIKit
import MapKit

enum FoodCategory: String, CaseIterable {
    case all = "전체보기"
    case korean = "한식"
    case japanes = "일식"
    case chinese = "중식"
    case western = "양식"
}

class RestaurantMapViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!
    
    let filteredData = RestaurantList.filteredDataDict // 카테고리별로 분류된 데이터 [카테고리: [식당목록]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setMapkit()
        setupMapView(filteredData[FoodCategory.all.rawValue]!)
    }
}


// MARK: MapKit 관련
extension RestaurantMapViewController {
    func setMapkit() {
        // 지도의 좌표 (E1 충전소)
        let center = RestaurantList.center
        // 지정 좌표로부터 몇 미터까지 보여줄까~
        mapView.region = MKCoordinateRegion(center: center, latitudinalMeters: 200, longitudinalMeters: 200)
    }
    
    // Annotation 세팅
    func setupMapView(_ restaurantList: [Restaurant]) {
        // 받아온 식당 리스트 돌면서 핀(Annotation) 박기
        for restaurant in restaurantList {
            let coordinate = CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)
            let annotaion = MKPointAnnotation()
            annotaion.title = restaurant.name
            annotaion.coordinate = coordinate
            mapView.addAnnotation(annotaion)
        }
    }

    // Annotation 다 없애기
    func removeAnnotations() {
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
    }
}

// MARK: Navigation
// 연습삼아 만든 setupUI 프로토콜 채택
extension RestaurantMapViewController: setupUI {
    func setupNavigation() {
        navigationItem.title = "지도로 식당 모아보기"
        let actionSheet = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterBtnTapped))
        navigationItem.rightBarButtonItem = actionSheet
    }
}

// MARK: Action
extension RestaurantMapViewController {
    // alertAction 생성
    func configureUIAlertAction(_ foodType: FoodCategory) -> UIAlertAction {
        let alertAction = UIAlertAction(title: foodType.rawValue, style: .default) { _ in
            // key값(title)으로 데이터 불러오기
            guard let result = self.filteredData[foodType.rawValue] else { return }
            self.removeAnnotations()
            self.setupMapView(result)
        }
        return alertAction
    }
    
    // 네비게이션 액션
    @objc func filterBtnTapped(_ sender: UIButton) {
        // actionSheet 생성
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // 액션 생성 및 등록
        FoodCategory.allCases.forEach { category in
            alert.addAction(configureUIAlertAction(category))
        }
        // actionSheet 띄우기
        present(alert, animated: true)
    }
}
