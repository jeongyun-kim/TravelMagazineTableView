//
//  RestaurantMapViewController.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/30/24.
//

import UIKit
import MapKit

class RestaurantMapViewController: UIViewController {
    static let vcIdentifier = "RestaurantMapViewController"
    
    @IBOutlet var mapView: MKMapView!
    
    lazy var koreanList = RestaurantList.getFilteredList(category: "한식")
    lazy var japaneseList = RestaurantList.getFilteredList(category: "일식")
    lazy var chineseList = RestaurantList.getFilteredList(category: "중식")
    lazy var westernList = RestaurantList.getFilteredList(category: "양식")
    let allList = RestaurantList.getFilteredList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupMapView(allList)
    }
}


// MARK: Annotation 그리기/지우기
extension RestaurantMapViewController {
    // Annotation 세팅
    func setupMapView(_ restaurantList: [Restaurant]) {
        // 지도의 좌표 (E1 충전소)
        let center = RestaurantList.center
        // 지정 좌표로부터 몇 미터까지 보여줄까~
        mapView.region = MKCoordinateRegion(center: center, latitudinalMeters: 200, longitudinalMeters: 200)
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


// MARK: 네비게이션 세팅
// 연습삼아 만든 setupUI 프로토콜 채택
extension RestaurantMapViewController: setupUI {
    func setupNavigation() {
        navigationItem.title = "지도로 식당 모아보기"
        let actionSheet = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterBtnTapped))
        navigationItem.rightBarButtonItem = actionSheet
    }
}


// MARK: 액션 관련..?
extension RestaurantMapViewController {
    // alertAction 생성
    func configureUIAlertAction(_ title: String, list: [Restaurant]) -> UIAlertAction{
        let alertAction = UIAlertAction(title: title, style: .default) { _ in
            self.removeAnnotations()
            self.setupMapView(list)
        }
        return alertAction
    }
    
    // 네비게이션 액션
    @objc func filterBtnTapped(_ sender: UIButton) {
        // actionSheet 생성
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // 등록할 액션 생성
        let all = configureUIAlertAction("전체보기", list: allList)
        let korean = configureUIAlertAction("한식만 보기", list: koreanList)
        let japanese = configureUIAlertAction("일식만 보기", list: japaneseList)
        let chinese = configureUIAlertAction("중식만 보기", list: chineseList)
        let western = configureUIAlertAction("양식만 보기", list: westernList)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        // 액션 등록
        [all, korean, japanese, chinese, western, cancel].forEach { action in
            alert.addAction(action)
        }
        // actionSheet 띄우기
        present(alert, animated: true)
    }
}
