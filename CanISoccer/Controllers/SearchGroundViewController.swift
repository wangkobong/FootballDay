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
    var locations: [Places] = []
    
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
        mapView.showsUserLocation = true

    }
    

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        locations.removeAll()
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        if let locationKeyword = searchTextFiled.text {
            let keyword = "\(locationKeyword) \(groundKeyword)"
            WeatherManager.shared.fetchSearchPlaces(keyword) { items in
                print(items[0]["address"])
                for (_, value) in items {
                    let address = value["address_name"].stringValue
                    let phone = value["phone"].stringValue
                    let placeName = value["place_name"].stringValue
                    let placeURL = value["place_url"].stringValue
                    let latitude = value["y"].stringValue
                    let longitude = value["x"].stringValue
                    let location = Places(placeName: placeName, address: address, phone: phone, placeURL: placeURL, latitude: latitude, longitude: longitude)
                    print("location: \(location)")
                    self.locations.append(location)
                }
            }
        } else {
            print("통신실패")
        }
        print("testddfdfsf: \(locations)")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.setAnnotation()
        }
    }
    
    func setAnnotation() {
        var annotations = [MKAnnotation]()
        for location in locations {
            let annotation = MKPointAnnotation()
            let lat = (location.latitude as NSString).doubleValue
            let long = (location.longitude as NSString).doubleValue
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            print("coordinate: \(coordinate)")
            let placeName = location.placeName
            print("placeName: \(placeName)")
            annotation.title = placeName
            annotation.coordinate = coordinate
            annotations.append(annotation)
            }
        mapView.addAnnotations(annotations)
        if let lastAnnotation = annotations.last {
            let region = MKCoordinateRegion(center: lastAnnotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.2))
            mapView.setRegion(region, animated: true)
        }
        locationManager.startUpdatingLocation()
    }
    
    
    @IBAction func selectGroundPressed(_ sender: UISegmentedControl) {
        groundKeyword = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "축구장"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
    }
}


// MARK: -
extension SearchGroundViewController: CLLocationManagerDelegate {

    //4. 사용자가 위치 허용을 한 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let coordinate = locations.last?.coordinate {


//            let annotation = MKPointAnnotation()
//            annotation.title = "CURRENT LOCATION"
//            annotation.coordinate = coordinate
//            mapView.addAnnotation(annotation)
//
//            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//            let region = MKCoordinateRegion(center: coordinate, span: span)
//            mapView.setRegion(region, animated: true)


        } else {
            print("Location Cannot Find")
        }
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
