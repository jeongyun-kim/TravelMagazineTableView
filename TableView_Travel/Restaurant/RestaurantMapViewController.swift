//
//  RestaurantMapViewController.swift
//  TableView_Travel
//
//  Created by 김정윤 on 5/30/24.
//

import UIKit
import CoreLocation
import MapKit
import SnapKit

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

// 위치 받아오는 방식 : 권한 확인(아이폰 내 설정이 켜져있는지) -> 켜져있다면 앱 권한 확인 -> 권한이 notDetermined라면 권한 허용해달라는 창 띄우기 -> 권한 변경되면 didChange 호출 -> 이 때, 다시 권한을 확인 -> 권한 상태가 whenInUse라면 didUpdateLocateMethod 통해서 사용자의 위치 받아오기

class RestaurantMapViewController: UIViewController {
    let mapView = MKMapView()

    lazy var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
        setupUI()
        setupNavigation()
        setupMapView(FoodCategory.all.restauranList)
        locationManager.delegate = self
    }
    
    private func setupHierarchy() {
        view.addSubview(mapView)
    }
    
    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
}

extension RestaurantMapViewController {
    private func checkLocationAuthorization() {
        var status: CLAuthorizationStatus // 권한 상태
        
        // iOS14를 기준으로 변했기 때문에 14이상인지 미만인지 체크할 것
        // - 2024년 6월 9일 기준 iOS16 이전 버전이 3%이므로 꼭 확인할 필요는 X
        if #available(iOS 14.0, *) { // iOS14.0 이상은 다
            status = locationManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
       
        // 권한 상태에 따른 처리
        switch status {
        case .notDetermined: // 어떠한 권한도 선택되지 않은 상태 -> 권한 창 띄우기
            // 위치 정확도 세팅(desiredAccuracy) : kCLLocationAccuracyBest가 Default
            // 권한 요청 창 띄우기
            locationManager.requestWhenInUseAuthorization()
        case .denied: // 권한 거부 상태 -> iOS 설정창에서 설정변경해달라는 Alert 띄우기
            // 다수의 앱이 설정화면으로 넘겨주는 Alert Action 사용 ex) 카카오맵, 당근, 요기요, 에버랜드
            print("권한 거부 상태!")
        case .authorizedWhenInUse: // 사용하는 동안만 허용 -> 위치 정보 받아오는 로직 구현
            print("권한 허용 상태!")
            locationManager.startUpdatingLocation()
        default:
            print("default")
        }
    }
}

extension RestaurantMapViewController: CLLocationManagerDelegate {
    private func setRegionOnMapView() {}
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("권한의 상태가 업데이트됐어요")
        
        guard let location = locations.last?.coordinate else { return }
        let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 100, longitudinalMeters: 100)
        mapView.setRegion(region, animated: true)
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("권한의 상태가 변경됐어요")
        checkLocationAuthorization()
    }
}


// MARK: MapKit 관련
extension RestaurantMapViewController {
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
            let result = foodType.restauranList
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
