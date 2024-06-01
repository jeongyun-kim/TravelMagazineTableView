//
//  RestaurantMapViewController.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/30/24.
//

import UIKit
import MapKit

class RestaurantMapViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!
    
    let filteredData = RestaurantList.filteredDataDict // 카테고리별로 분류된 데이터 [카테고리: [식당목록]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setMapkit()
        setupMapView(filteredData["전체보기"]!)
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
    func configureUIAlertAction(_ title: String) -> UIAlertAction {
        let alertAction = UIAlertAction(title: title, style: .default) { _ in
            // key값(title)으로 데이터 불러오기
            guard let result = self.filteredData[title] else { return }
            self.removeAnnotations()
            self.setupMapView(result)
        }
        return alertAction
    }
    
    // 네비게이션 액션
    @objc func filterBtnTapped(_ sender: UIButton) {
        // actionSheet 생성
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // 등록할 액션 생성
        let all = configureUIAlertAction("전체보기")
        let korean = configureUIAlertAction("한식")
        let japanese = configureUIAlertAction("일식")
        let chinese = configureUIAlertAction("중식")
        let western = configureUIAlertAction("양식")
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        // 액션 등록
        [all, korean, japanese, chinese, western, cancel].forEach { action in
            alert.addAction(action)
        }
        // actionSheet 띄우기
        present(alert, animated: true)
    }
}
