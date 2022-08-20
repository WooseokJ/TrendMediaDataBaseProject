//
//  MapViewController.swift
//  TrendMediaDataBaseProject
//
//  Created by useok on 2022/08/11.
//

import UIKit
import MapKit
import CoreLocation
class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    let locationManager = CLLocationManager() //생성과 동시에 didUpdateLocations 실행
    let TheaterArray = TheaterData().mapAnnotations

    override func viewDidLoad() {
//        print(#function)
        super.viewDidLoad()
        locationManager.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "filter", style: .plain, target: self, action: #selector(filterClicked))
        let center = CLLocationCoordinate2D(latitude: 37.511108, longitude: 127.021369)
        TheaterMove(center: center)
        AllAnnotation()
    }
    // filter 네비바 클릭
    @objc func filterClicked() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let all = UIAlertAction(title: "전체보기", style: .default) {_ in
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.AllAnnotation()
        }
        
        let lotte = UIAlertAction(title: "롯데시네마", style: .default){ _ in
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.SelectAnnotation(TheaterName: "롯데시네마")
            
        }
        let cgv = UIAlertAction(title:"cgv",style: .default) {_ in
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.SelectAnnotation(TheaterName: "CGV")
        }
        let mega = UIAlertAction(title: "메가박스", style: .default){ _ in
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.SelectAnnotation(TheaterName: "메가박스")
        }
        alert.addAction(mega)
        alert.addAction(lotte)
        alert.addAction(cgv)
        alert.addAction(all)
        self.present(alert, animated: true)
    }

    // 좌표이동
    func TheaterMove(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 10000, longitudinalMeters: 10000)
        self.mapView.setRegion(region, animated: true)
    }
    // 특정한 영화관 띄우기
    func SelectAnnotation(TheaterName: String) {

        TheaterArray.filter{
            $0.type == TheaterName
        }.map{
            let pinLocation = CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = pinLocation
            annotation.title = $0.location
            mapView.addAnnotation(annotation)
        }
    }
    //전체 띄우기
    func AllAnnotation() {
        TheaterArray.map{
            let pinLocation = CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = pinLocation
            annotation.title = $0.location
            mapView.addAnnotation(annotation)
        }
    }
    //2 번
    func checkLocationService() {
//        print(#function)
        let authorStatus : CLAuthorizationStatus
        if #available(iOS 14.0 , *) {
            authorStatus = locationManager.authorizationStatus
        }
        //ios 14미만
        else{authorStatus = CLLocationManager.authorizationStatus()}

        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocation(authorStatus)
        }
        
        else {
            print("위치 서비스 꺼져잇음")
            showRequestLocationServiceAlert()
        }

    }
    //3 번
    func checkCurrentLocation(_ authorStatus: CLAuthorizationStatus) {
//        print(#function)
        switch authorStatus {
            //4
        case .notDetermined:
            print("notDetermined")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization() //앱사용하는동안 위치관련요청
        case .restricted,.denied:
            print("거부")
            showRequestLocationServiceAlert()
        case .authorizedWhenInUse:
            print("When is Use")
            locationManager.startUpdatingLocation() //// 여러번 update 됨
//            locationManager.requestLocation() // 한번 호출 되지만 위치정보 받아오는게 느림.
        default: print("default")
        }
//        case .authorizedAlways:
//        case .authorized:

    }
    func showRequestLocationServiceAlert() {
//        print(#function)
      let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
      let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
          //성정까지 이동하거나 설정 세부화면까지 이동하거나
          //한번도설정앱에 들어가지않은경우, 막다운받은앱이거나
          if let appSetting = URL(string: UIApplication.openSettingsURLString) {
              UIApplication.shared.open(appSetting)
          }
      }
      let cancel = UIAlertAction(title: "취소", style: .default)
      requestLocationServiceAlert.addAction(cancel)
      requestLocationServiceAlert.addAction(goSetting)
      present(requestLocationServiceAlert, animated: true, completion: nil)
    }
}

extension MapViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("😅😅","#function") //
        if let cooridinate = locations.last?.coordinate {
            print(cooridinate)
            TheaterMove(center: cooridinate)
        }
        locationManager.stopUpdatingLocation() // update 멈춰줌
//        locationManager.stopUpdatingHeading() // 내손가락이 문제..ㅠ 자동완성너무믿지말자ㅠ
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(#function)
    }
    //1 번시작
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        print(#function)
        checkLocationService()
    }
    //ios 14미만
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//    }
}


