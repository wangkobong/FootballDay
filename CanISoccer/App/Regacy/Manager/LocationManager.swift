////
////  LocationManager.swift
////  CanISoccer
////
////  Created by sungyeon kim on 2022/07/05.
////
//
//import RxSwift
//import RxCocoa
//import CoreLocation
//
//final class LocationPermissionManager {
//    static let shared = LocationPermissionManager()
//    private let disposeBag = DisposeBag()
//    
//    let locationSubject = BehaviorSubject<CLLocationCoordinate2D?>(value: nil)
//    private let locationManager: CLLocationManager = {
//        let manager = CLLocationManager()
//        manager.desiredAccuracy = kCLLocationAccuracyBest
//        manager.distanceFilter = kCLDistanceFilterNone
//        return manager
//    }()
//    
//    private init() {
//        
//        self.locationManager.rx.didUpdateLocations
//        
//            .compactMap(\.locations.last?.coordinate)
//            .bind(onNext: self.locationSubject.onNext(_:))
//            .disposed(by: self.disposeBag)
//        self.locationManager.startUpdatingLocation()
//    }
//    
//    func requestLocation() -> Observable<CLAuthorizationStatus> {
//      return Observable<CLAuthorizationStatus>
//        .deferred { [weak self] in
//          guard let ss = self else { return .empty() }
//          ss.locationManager.requestWhenInUseAuthorization()
//          return ss.locationManager.rx.didChangeAuthorization
//            .map { $1 }
//            .filter { $0 != .notDetermined }
//            .do(onNext: { _ in ss.locationManager.startUpdatingLocation() })
//            .take(1)
//        }
//    }
//}
