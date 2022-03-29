//
//  ViewController.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2021/11/15.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation
import CoreLocationUI
import RealmSwift
import Toast


class MainViewController: UIViewController {
    
    let localRealm = try! Realm()
    
    var tasks: Results<Forecast>!
    var filteredTasks: Results<Forecast>!
    var searchedTask: Results<Forecast>!
    
    let locationManager = CLLocationManager()
    var currentLocation:CLLocationCoordinate2D!
    var latitude = ""
    var longitude = ""
    var locality = ""
    var thorughfare = ""
    var selectedTime = 0.0
    var currentUnixtime: TimeInterval = 0
    let todayOnlyDate = Int(Date().onlyDate)

    
    @IBOutlet weak var searchTextField: UITextField!
    {
        didSet {
            let placeholderText = NSAttributedString(string: "주소를 입력해주세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            searchTextField.attributedPlaceholder = placeholderText
        }
    }
    
    @IBOutlet weak var datePickerTextField: UITextField!{
        didSet {
            let placeholderText = NSAttributedString(string: "시간대를 선택해주세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            datePickerTextField.attributedPlaceholder = placeholderText
        }
    }
    @IBOutlet weak var temperatureLable: UILabel!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    @IBOutlet weak var weatherStatusImageView: UIImageView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var recommendationLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.datePickerTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone))
    
        locationManager.delegate = self
        searchTextField.delegate = self
        datePickerTextField.delegate = self
        
        print("Realm is located at:", localRealm.configuration.fileURL!)
        
        currentUnixtime = Double(Date().timeIntervalSince1970)
        tasks = localRealm.objects(Forecast.self).filter("predictedTimeUnixData > \(currentUnixtime) && regDateData == \(todayOnlyDate!)")
    }   

    @IBAction func currentLocationBtnPressed(_ sender: UIButton) {
        print("currentLocationBtnPressed")
        locationManager.startUpdatingLocation()
    }
    
    
    @IBAction func searchBtnPressed(_ sender: UIButton) {

        guard let address = self.searchTextField.text else { return }
        let group = DispatchGroup()
        if address.isEmpty && selectedTime == 0.0 {
            showToastMessage(message: "시간대 선택 후 주소를 xx구 xx동 형식으로 입력해주세요.", title: "검색할 주소와 시간을 입력해주세요!")
        } else if address.isEmpty {
            showToastMessage(message: "xx구 xx동 형식으로 입력해주세요.", title: "검색할 지역을 입력해주세요.")
        } else if selectedTime == 0.0 {
            showToastMessage(message: "지금 시간보다 이후의 시간대를 선택해주세요.", title: "검색할 시간대를 선택해주세요.")
        } else {
            DispatchQueue.global().async(group: group) {
                group.enter()
                WeatherManager.shared.fetchGeocoding(address: address) { item, code in
                    let x = item[0]["x"].stringValue
                    let y = item[0]["y"].stringValue
                    self.latitude = y
                    self.longitude = x
                    if code == 200 {
                        group.leave()
                    } else {
                        self.showToastMessage(message: "정확한 주소를 적어주세요", title: "잘못된 주소입니다.")
                        return
                    }
                    
                }
                
                group.notify(queue: DispatchQueue.main) {
                    // 이 부분을 함수로 묶어 status code가 200일 경우 실행하도록 하자!
                    let isExisting = self.localRealm.objects(Forecast.self).filter("regDateData == \(self.todayOnlyDate!) && searchedLocationData == '\(address)'")
                    
                    if isExisting.isEmpty {
                        print("X좌표: \(self.longitude), Y좌표: \(self.latitude)")
                        WeatherManager.shared.fetchWeatherForecast(self.latitude, self.longitude){ list, code in

                            switch code {
                                case 200:
                                    for item in list {
                                        let predictedTimeUnix = item["dt"].doubleValue
                                        let predictedTimeData = Date().dateToString(unixTime: predictedTimeUnix)
                                        let searchedLocation = address
                                        let temp = item["main"]["temp"].doubleValue
                                        let tempFeelsLike = item["main"]["feels_like"].doubleValue
                                        let regDate = Date().onlyDate
                                        let probabilityOfRain = item["pop"].doubleValue
                                        let weatherID = item["weather"][0]["id"].intValue
                                        let weatherStatus = item["weather"][0]["main"].stringValue
                                        
                                        let task = Forecast(predictedTimeUnixData: predictedTimeUnix, predictedTimeData: predictedTimeData, searchedLocationData: searchedLocation, tempData: temp, tempFeelsLikeData: tempFeelsLike, regDateData: Int(regDate)!, probabilityOfRain: probabilityOfRain, weatherIdData: weatherID, weatherStatusData: weatherStatus)
                                        
                                        try! self.localRealm.write {
                                            self.localRealm.add(task)
                                        }
                                    }
                                    self.tasks = self.localRealm.objects(Forecast.self).filter("predictedTimeUnixData > \(self.currentUnixtime) && regDateData == \(self.todayOnlyDate!) && searchedLocationData == '\(address)'")
                    
                                    self.setDescription(tasks: self.tasks, address: address)
                                case 400:
                                    self.showToastMessage(message: "(ex. xx구 xx동 형식으로 입력해주세요)", title: "유효하지 않은 주소입니다.")
                                default:
                                    self.showToastMessage(message: "관리자에게 문의해주세요!", title: "알 수 없는 오류가 발생했습니다.")
                            }
                            self.initCoordinates()
                        }

                    } else {
                        print("이미 저장된 주소의 일기예보: \(address), 오늘날짜: \(self.todayOnlyDate!)")
                        self.tasks = self.localRealm.objects(Forecast.self).filter("predictedTimeUnixData > \(self.currentUnixtime) && regDateData == \(self.todayOnlyDate!) && searchedLocationData == '\(address)'")

                        self.setDescription(tasks: self.tasks, address: address)
                    }
                }
            }
        }

    }
    
    func printLocality(_ lat: CLLocationDegrees, _ long: CLLocationDegrees){
        print(#function)
        let findLocation = CLLocation(latitude: lat, longitude: long)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")

        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale) { placemarks, error in
            
            if let placemark = placemarks?[0] {
                self.locality = placemark.locality!
                self.thorughfare = placemark.thoroughfare!
                self.weatherDescriptionLabel.text = "\(self.locality) \(self.thorughfare)의 날씨입니다."
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
    }
    
    @objc func tapDone() {
        if let datePicker = self.datePickerTextField.inputView as? UIDatePicker {
            selectedTime = datePicker.date.timeIntervalSince1970
            let unixTimeToStirng = Date().setTimestamp(unixTime: selectedTime)
            if currentUnixtime > selectedTime {
                showToastMessage(message: "현재시간 이후의 시간을 선택해주세요!", title: "지난 시간을 입력할 수 없습니다.")
            } else {
                self.datePickerTextField.text = unixTimeToStirng
            }
            
        }
        
        if searchTextField.text == "" {
            self.searchTextField.becomeFirstResponder()
            self.datePickerTextField.resignFirstResponder()
        } else {
            self.datePickerTextField.resignFirstResponder()
        }
    }
    

}


// MARK: - CLLocationManagerDelegate
extension MainViewController: CLLocationManagerDelegate {
    
    func checkUserLocationServiceAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("iOS 위치 서비스를 켜주세요")
        }
    }
    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined, .restricted:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            showAlert(title: "위치권한 설정을 거부하셨습니다", message: "위치 설정 화면으로 가시겠습니까?", okTitle: "설정으로 이동") {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(NSURL(string:UIApplication.openSettingsURLString)! as URL)
                } else {
                    UIApplication.shared.openURL(NSURL(string: UIApplication.openSettingsURLString)! as URL)
                }
            }
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            print("DEFAULT")
        }
        
        if #available(iOS 14.0, *) {
            let accurancyState = locationManager.accuracyAuthorization
            
            switch accurancyState {
            case .fullAccuracy:
                print("FULL")
            case .reducedAccuracy:
                print("REDUCE")
            @unknown default:
                print("DEFAULT")
                
            }

        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let coordinates = locations.last?.coordinate {
            let lat = coordinates.latitude
            let long = coordinates.longitude

            fetchCurrentWeather(lat: lat, long: long)
            printLocality(lat, long)
            locationManager.stopUpdatingLocation()
        } else {
            print("Location Cannot Find")
        }

    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
        showAlert(title: "위치권한 설정을 거부하셨습니다", message: "위치 설정 화면으로 가시겠습니까?", okTitle: "설정으로 이동") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(NSURL(string:UIApplication.openSettingsURLString)! as URL)
            } else {
                UIApplication.shared.openURL(NSURL(string: UIApplication.openSettingsURLString)! as URL)
            }
        }
        print("error: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkUserLocationServiceAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserLocationServiceAuthorization()
    }
    
    func setDescription(tasks: Results<Forecast>!, address: String) {
        for task in self.tasks {
            if task["predictedTimeUnixData"] as! Double > self.selectedTime {
                let predictedTimeUnixDataByUser = task["predictedTimeUnixData"] as! Double
                self.searchedTask = self.localRealm.objects(Forecast.self)
                .filter("predictedTimeUnixData == \(predictedTimeUnixDataByUser) && searchedLocationData == '\(address)' && regDateData == \(todayOnlyDate ?? 0)")
                print(self.searchedTask!)
                break
            }
        }
        
        guard let temperatureData = self.searchedTask[0]["tempData"] as? Double else { return }
        guard let feelsLikeTemperatureData = self.searchedTask[0]["tempFeelsLikeData"] as? Double else { return }
        let temperature = floor(temperatureData)
        let temperatureToInto = Int(temperature)
        guard let predictedTimeData = self.searchedTask[0]["predictedTimeData"] as? String else { return }
        let droppedPredictedTimeData = String(predictedTimeData.dropFirst(8))
        let feelsLikeTemperature = floor(feelsLikeTemperatureData)
        let feelsLikeTemperatureToInt = Int(feelsLikeTemperature)
        let condition = self.searchedTask[0]["weatherStatusData"] as? String
        let conditiondId = self.searchedTask[0]["weatherIdData"] as? Int
        let forecastIconId = WeatherModel(conditionId: conditiondId ?? 0)
        let recommendationLabelData = RecommendationModel(feelsLikeTemperature: feelsLikeTemperatureToInt)
        let hoursLabelData = HoursModel(hours: droppedPredictedTimeData)
        let probabilityOfRain = self.searchedTask[0]["probabilityOfRain"] as? Double ?? 0.0

        self.temperatureLable.text = "\(temperatureToInto)"
        self.weatherStatusLabel.text = condition
        self.weatherStatusImageView.image = UIImage(systemName: forecastIconId.conditionName)
        self.weatherDescriptionLabel.text = "체감온도는 \(feelsLikeTemperatureToInt)°C, 강수확률은 \(Int(probabilityOfRain * 100))% 입니다."
        self.recommendationLabel.text = "\(recommendationLabelData.conditionTemperature) \(hoursLabelData.recommendSunblock)"
    }
    
    func showToastMessage(message: String, title: String) {
        var style = ToastStyle()
        style.messageColor = .white
        style.titleColor = .white
        self.view.makeToast(message, duration: 2.0, position: .center, title: title, image: UIImage(systemName: "x.circle.fill"), style: style, completion: nil)
    }
    
    func fetchCurrentWeather(lat: CLLocationDegrees, long: CLLocationDegrees) {
        WeatherManager.shared.fetchCurrentweather(lat, long) { json in
            let temperatureData = json["main"]["temp"].doubleValue
            let temperature = Int(temperatureData)
            let condition = json["weather"][0]["main"].stringValue
            let conditiondId = json["weather"][0]["id"].stringValue
            let data = WeatherModel(conditionId: Int(conditiondId) ?? 0)
            self.temperatureLable.text = "\(temperature)"
            self.weatherStatusLabel.text = condition
            self.weatherStatusImageView.image = UIImage(systemName: data.conditionName)
            self.recommendationLabel.text = ""
        }
    }
    
    func initCoordinates() {
        self.latitude = ""
        self.longitude = ""
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.searchTextField {
            if self.datePickerTextField.text == "" {
                self.datePickerTextField.becomeFirstResponder()
            } else {
                self.searchTextField.resignFirstResponder()
                self.searchBtnPressed(self.searchButton)
            }
        }
        return true
    }
}
