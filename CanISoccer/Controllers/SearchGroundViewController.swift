//
//  SearchGroundViewController.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2021/11/17.
//

import UIKit

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation
import CoreLocationUI
import RealmSwift
import Toast
import MapKit

class SearchGroundViewController: UIViewController {

    var groundKeyword = "축구장"
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchTextFiled: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let location = CLLocationCoordinate2D(latitude: 37.49826709543227, longitude: 127.02763571410598)
//        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.1)
//        let region = MKCoordinateRegion(center: location, span: span)
//        mapView.setRegion(region, animated: true)
//
//        let annotaion = MKPointAnnotation()
//        annotaion.title = "다시 가고싶다"
//        annotaion.coordinate = location
//        mapView.addAnnotation(annotaion)
//
        //맵뷰에 어노테이션을 삭제하고자 할 때
//        let annotations = mapView.annotations
//        mapView.removeAnnotations(annotations)
//
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        mapView.showsUserLocation = true

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.viewWillDisappear(false)
        self.locationManager.stopUpdatingLocation()
    }

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        print(#function)
        if let locationKeyword = searchTextFiled.text {
            let keyword = "\(locationKeyword) \(groundKeyword)"
            WeatherManager.shared.fetchSearchPlaces(keyword)
            print("keyword: \(keyword)")
        } else {
            print("통신실패")
        }
    }
    
    
    @IBAction func selectGroundPressed(_ sender: UISegmentedControl) {
        groundKeyword = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "축구장"
        print(groundKeyword)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
    }
}


// MARK: -
extension SearchGroundViewController: CLLocationManagerDelegate {

    //4. 사용자가 위치 허용을 한 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        print(locations)
        
        if let coordinate = locations.last?.coordinate {
             
            let annotation = MKPointAnnotation()
            annotation.title = "현재 위치"
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
            
            //10. (중요)
            locationManager.startUpdatingLocation()
        } else {
            print("Location Cannot Find")
        }
        locationManager.stopUpdatingLocation()
    }
    
    //5. 위치 접근이 실패했을 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    
}

extension SearchGroundViewController: MKMapViewDelegate {
    
    //맵 어노테이션 클릭 시 이벤트 핸들링
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("가고 싶다 ㅣ진짜")
    }
}
