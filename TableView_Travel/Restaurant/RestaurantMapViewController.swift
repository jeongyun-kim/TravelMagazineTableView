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

// 위치 받아오는 방식 : 권한 확인(아이폰 내 설정이 켜져있는지) -> 켜져있다면 앱 권한 확인 -> 권한이 notDetermined라면 권한 허용해달라는 창 띄우기 -> 권한 변경되면 didChange 호출 -> 이 때, 다시 권한을 확인 -> 권한 상태가 whenInUse라면 didUpdateLocateMethod 통해서 사용자의 위치 받아오기

class RestaurantMapViewController: UIViewController {
    let mapView = MKMapView()
    
    lazy var gpsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        button.addTarget(self, action: #selector(gpsBtnTapped), for: .touchUpInside)
        return button
    }()

    lazy var locationManager = CLLocationManager()
    
    lazy var restaurantList: [Restaurant] = FoodCategory.all.restauranList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
        setupNavigation()
        setupUI()
        makeRestaurantAnnotation(restaurantList)
    }
    
    private func setupHierarchy() {
        view.addSubview(mapView)
        view.addSubview(gpsButton)
    }
    
    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        gpsButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.size.equalTo(40)
        }
    }
    
    func setupNavigation() {
        navigationItem.title = "지도로 식당 모아보기"
        let actionSheet = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterBtnTapped))
        navigationItem.rightBarButtonItem = actionSheet
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        locationManager.delegate = self
    }
}

// MARK: Location 처리 관련
extension RestaurantMapViewController {
    // 디바이스 설정에 위치 권한이 켜져있는지 확인
    private func checkDeviceLocationAuthorization() {
        if CLLocationManager.locationServicesEnabled() { // 타입 메서드
            checkCurrentLocationAuthorization()
        } else {
            showLocationDeniedAlert()
        }
    }
    
    private func checkCurrentLocationAuthorization() {
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
            gpsButton.setImage(UIImage(systemName: "location.circle"), for: .normal)
            showLocationDeniedAlert()
        case .authorizedWhenInUse: // 사용하는 동안만 허용 -> 위치 정보 받아오는 로직 구현
            gpsButton.setImage(UIImage(systemName: "location.circle.fill"), for: .normal)
            locationManager.startUpdatingLocation() // 위치 업데이트
        default:
            break
        }
    }
    
    private func showLocationDeniedAlert() {
        let alert = UIAlertController(title: LocationCase.alertTitle, message: LocationCase.alertMessage, preferredStyle: .alert)
        let cancel = UIAlertAction(title: LocationCase.cancel, style: .cancel)
        let goSetting = UIAlertAction(title: LocationCase.settingActionTitle, style: .default) { _ in
            // 설정 열어주기
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }
        alert.addAction(cancel)
        alert.addAction(goSetting)
        present(alert, animated: true)
    }
    
    // 사용자의 현재 위치 받아올 때, 원래 있던 Annotation 제거하고 다시 그리기
    @objc func gpsBtnTapped(_ sender: UIButton) {
        removeAnnotations(true)
        checkDeviceLocationAuthorization()
    }
    
    private func setRegionOnMapViewAndMakeAnnotation(_ center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 100, longitudinalMeters: 100)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: center.latitude, longitude: center.longitude)
        annotation.title = LocationCase.userLocation
        mapView.addAnnotation(annotation)
    }
}

// MARK: LocationMangerDelegate
extension RestaurantMapViewController: CLLocationManagerDelegate {
    // 권한 상태 업데이트 시 호출
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 권한이 제대로 허용되어있다면 내 위치 받아오기
        guard let location = locations.last?.coordinate else { return }
        setRegionOnMapViewAndMakeAnnotation(location)
        // 자주 받아오지 않게 처리
        locationManager.stopUpdatingLocation()
    }
    
    // 권한의 상태 변경 시 호출
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkCurrentLocationAuthorization()
    }
}


// MARK: MapKit 관련
extension RestaurantMapViewController {
    // Annotation 세팅
    func makeRestaurantAnnotation(_ restaurantList: [Restaurant]) {
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
    func removeAnnotations(_ isUserLocation: Bool) {
        let annotations = mapView.annotations
        var annotationsToRemove: [MKAnnotation] = []
        if isUserLocation {
            annotationsToRemove = annotations.filter { $0.title == LocationCase.userLocation }
        } else {
            annotationsToRemove = annotations.filter { $0.title != LocationCase.userLocation }
        }
        mapView.removeAnnotations(annotationsToRemove)
    }
    
    // alertAction 생성
    func configureUIAlertAction(_ foodType: FoodCategory) -> UIAlertAction {
        let alertAction = UIAlertAction(title: foodType.rawValue, style: .default) { _ in
            // key값(title)으로 데이터 불러오기
            self.restaurantList = foodType.restauranList
            self.removeAnnotations(false)
            self.makeRestaurantAnnotation(self.restaurantList)
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
        alert.addAction(UIAlertAction(title: LocationCase.cancel, style: .cancel))
        // actionSheet 띄우기
        present(alert, animated: true)
    }
}
