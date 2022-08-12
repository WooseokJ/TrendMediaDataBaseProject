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

    let Manager = CLLocationManager()
    let TheaterArray = TheaterList().mapAnnotations

    override func viewDidLoad() {
        super.viewDidLoad()
        Manager.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "filter", style: .plain, target: self, action: #selector(filterClicked))
        let center = CLLocationCoordinate2D(latitude: 37.498471, longitude: 127.028618)
        TheaterMove(center: center)
        AllAnnotation()
    }
//    override func viewDidAppear(_ animated: Bool) {
//        showRequestLocationServiceAlert()
//    }
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
        mapView.setRegion(region, animated: true)
    }
    // 특정한 영화관 띄우기
    func SelectAnnotation(TheaterName: String) {
        for array in TheaterArray{
            let pinLocation = CLLocationCoordinate2D(latitude: array.latitude, longitude: array.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = pinLocation
            annotation.title = array.location
            if array.type == TheaterName {
                mapView.addAnnotation(annotation)
            }
        }
    }
    //전체 띄우기
    func AllAnnotation() {
        for array in TheaterArray{
            let pinLocation = CLLocationCoordinate2D(latitude: array.latitude, longitude: array.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = pinLocation
            annotation.title = array.location
            mapView.addAnnotation(annotation)
        }
    }
    //2
    func checkLocationService() {
        let authorStatus : CLAuthorizationStatus
        if #available(iOS 14.0 , *) {
            authorStatus = Manager.authorizationStatus
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
    //3
    func checkCurrentLocation(_ authorStatus: CLAuthorizationStatus) {
        switch authorStatus {
            //4
        case .notDetermined:
            print("notDetermined")
            Manager.desiredAccuracy = kCLLocationAccuracyBest
            Manager.requestWhenInUseAuthorization() //앱사용하는동안 위치관련요청
        case .restricted,.denied: print("거부")
        case .authorizedWhenInUse: Manager.startUpdatingLocation()
        default: print("default")
        }
//        case .authorizedAlways:
//        case .authorized:

    }
    func showRequestLocationServiceAlert() {
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
        print(#function)
        if let cooridinate = locations.last?.coordinate {
            TheaterMove(center: cooridinate)
        }
        Manager.stopUpdatingHeading()
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    //1
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationService()
    }
    //ios 14미만
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//    }
}

