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
    var locality = ""
    var thorughfare = ""
    var locations: [Places] = []
    var selectedAnnotation: MKPointAnnotation?
    let locationManager = CLLocationManager()
    var data = Places(placeName: "", address: "", phone: "", placeURL: "", latitude: "", longitude: "")
    
    
    var tasks: Results<Ground>!
    let localRealm = try! Realm()
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchTextFiled: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.showsUserLocation = true
        print("Realm is located at:", localRealm.configuration.fileURL!)
        tasks = localRealm.objects(Ground.self)
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
                    self.locations.append(location)
                }
                
                self.setAnnotation()
            }
        } else {
            print("통신실패")
        }
    }
    
    @IBAction func currentLocationButtonPressed(_ sender: UIButton) {
        locations.removeAll()
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        getLocality()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            let locationKeyword = "\(self.locality)"
            let keyword = "\(locationKeyword) \(self.groundKeyword)"
            if locationKeyword != "" {
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
                        self.locations.append(location)
                    }
                    self.setAnnotation()
                }
            } else {
                self.showToastMessage(message: "위치권한설정을 확인해주세요!", title: "위치정보를 받아올 수 없습니다.")
            }
        }
    }
    
    
    func setAnnotation() {
        var annotations = [MKAnnotation]()
        for location in locations {
            let annotation = MKPointAnnotation()
            let lat = (location.latitude as NSString).doubleValue
            let long = (location.longitude as NSString).doubleValue
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let placeName = location.placeName
            let address = location.address
            annotation.title = placeName
            annotation.subtitle = address
            annotation.coordinate = coordinate
            annotations.append(annotation)
            }
        mapView.addAnnotations(annotations)
        if let lastAnnotation = annotations.last {
            let region = MKCoordinateRegion(center: lastAnnotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    @IBAction func selectGroundPressed(_ sender: UISegmentedControl) {
        groundKeyword = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "축구장"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
    }
    
    func showToastMessage(message: String, title: String) {
        var style = ToastStyle()
        style.messageColor = .white
        style.titleColor = .white
        self.view.makeToast(message, duration: 2.0, position: .center, title: title, style: style, completion: nil)
    }
    
    func getLocality() {
        let myCoordinate = mapView.userLocation
        let findLocation = CLLocation(latitude: myCoordinate.coordinate.latitude, longitude: myCoordinate.coordinate.longitude)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")

        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale) { placemarks, error in
            if let placemark = placemarks?[0] {
                self.locality = placemark.locality ?? ""
                
            }
        }
    }
}


// MARK: -
extension SearchGroundViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {

            let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)

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
        let annotationsTitle = view.annotation?.title
        let newData = locations.filter { $0.placeName == annotationsTitle}
        let selectedAnnotationData = newData[0]
        data = selectedAnnotationData
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKUserLocation) {
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: String(annotation.hash))
            let rightButton = UIButton(type: .contactAdd)
            let tag = annotation.hash
            rightButton.tag = tag
            rightButton.addTarget(self, action: #selector(setFavorite), for: .touchUpInside)
            pinView.animatesDrop = true
            pinView.canShowCallout = true
            pinView.rightCalloutAccessoryView = rightButton
            return pinView
        }
        else {
            return nil
        }
    }
    
    @objc func setFavorite() {
        let placeName = data.placeName
        self.tasks = self.localRealm.objects(Ground.self).filter("placeNameData == '\(placeName)'")

        if tasks.isEmpty {
            let task = Ground(placeNameData: data.placeName, addressData: data.address, phoneData: data.phone, placeURLData: data.placeURL)
            try! self.localRealm.write {
                self.localRealm.add(task)
            }
            var style = ToastStyle()
            style.messageColor = .white
            style.titleColor = .white
            self.showToastMessage(message: "", title: "즐겨찾기 성공!")
        } else {
            self.showToastMessage(message: "", title: "이미 즐겨찾기된 구장입니다!")
        }

    }
}

