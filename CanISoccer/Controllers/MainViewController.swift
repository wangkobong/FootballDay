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
import RealmSwift
import Toast

class MainViewController: UIViewController {
    
    let localRealm = try! Realm()

    
    var tasks: Results<Forecast>!
    var filteredTasks: Results<Forecast>!
    var searchedTask: Results<Forecast>!
    
    var locationManager: CLLocationManager?
    var latitude = ""
    var longitude = ""
    var locality = ""
    var thorughfare = ""
    var selectedTime = 0.0
    var currentUnixtime: TimeInterval = 0
    let todayOnlyDate = Int(Date().onlyDate)

    var currentLocation:CLLocationCoordinate2D!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.datePickerTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone))
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.startUpdatingLocation()
        
        print("Realm is located at:", localRealm.configuration.fileURL!)
        
        currentUnixtime = Double(Date().timeIntervalSince1970)
        tasks = localRealm.objects(Forecast.self).filter("predictedTimeUnixData > \(currentUnixtime) && regDateData == \(todayOnlyDate!)")
        print("현재 unixTime: \(currentUnixtime)")

    }   

    
    
    @IBAction func currentLocationBtnPressed(_ sender: UIButton) {
        print("currentLocationBtnPressed")
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
                        self.showToastMessage(message: "좀 더 자세한 주소를 적어주세요", title: "잘못된 주소입니다.")
                        return
                    }
                }
                
                group.notify(queue: DispatchQueue.main) {
                    
                    let isExisting = self.localRealm.objects(Forecast.self).filter("regDateData == \(self.todayOnlyDate!) && searchedLocationData == '\(address)'")
                    
                    if isExisting.isEmpty {
                        print("X좌표: \(self.longitude), Y좌표: \(self.latitude)")
                        WeatherManager.shared.fetchWeatherForecast(self.latitude, self.longitude){ list, code in
                            print(#function)
                            print("fetchWeatherForecast: \(address)")
                            print("selectedTime: \(self.selectedTime)")
                            print(" fetchWeatherForecast X좌표: \(self.longitude), Y좌표: \(self.latitude)")
                            print("fetchWeatherForecast 상태코드 : \(code)")
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
        let findLocation = CLLocation(latitude: lat, longitude: long)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")

        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale) { placemarks, error in
            
            if let placemark = placemarks?[0] {
                self.locality = placemark.locality!
                self.thorughfare = placemark.thoroughfare!
            }
        }
    }
    
//    func setForecast() {
//        let isExisting = self.localRealm.objects(Forecast.self).filter("regDateData == \(self.todayOnlyDate!) && searchedLocationData == '\(address)'")
//    }
//
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
    }
    
    @objc func tapDone() {
        if let datePicker = self.datePickerTextField.inputView as? UIDatePicker {
            selectedTime = datePicker.date.timeIntervalSince1970
            let unixTimeToStirng = Date().setTimestamp(unixTime: selectedTime)
            print("selectedTime: \(selectedTime)")
            print("unixTimeToStirng: \(unixTimeToStirng)")

            if currentUnixtime > selectedTime {
                showToastMessage(message: "현재시간 이후의 시간을 선택해주세요!", title: "지난 시간을 입력할 수 없습니다.")
            } else {
                self.datePickerTextField.text = unixTimeToStirng
            }
            
        }
        self.datePickerTextField.resignFirstResponder() 
    }

}


// MARK: - CLLocationManagerDelegate
extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        guard let coordinates = locations.last?.coordinate else { return }
        let lat = coordinates.latitude
        let long = coordinates.longitude
        print(" didUpdateLocations 처음부분  \(self.locality), \(self.thorughfare) ")
        
        WeatherManager.shared.fetchCurrentweather(lat, long) { json in
            let temperatureData = json["main"]["temp"].doubleValue
            let temperature = Int(temperatureData)
            let condition = json["weather"][0]["main"].stringValue
            let conditiondId = json["weather"][0]["id"].stringValue
            let data = WeatherModel(conditionId: Int(conditiondId) ?? 0)
            self.temperatureLable.text = "\(temperature)"
            self.weatherStatusLabel.text = condition
            self.weatherStatusImageView.image = UIImage(systemName: data.conditionName)
 
        }
        locationManager?.stopUpdatingLocation()
        print(" didUpdateLocations CLLocationManagerDelegate \(self.locality), \(self.thorughfare)")
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
        let probabilityOfRain = self.searchedTask[0]["probabilityOfRain"] as? Double ?? 0.0 * 100

        self.temperatureLable.text = "\(temperatureToInto)"
        self.weatherStatusLabel.text = condition
        self.weatherStatusImageView.image = UIImage(systemName: forecastIconId.conditionName)
        self.weatherDescriptionLabel.text = "체감온도는 \(feelsLikeTemperatureToInt)°C, 강수확률은 \(probabilityOfRain)% 입니다."
        self.recommendationLabel.text = "\(recommendationLabelData.conditionTemperature) \(hoursLabelData.recommendSunblock)"
        print("String(predictedTimeData.dropFirst(8)): \(droppedPredictedTimeData)")
    }
    
    func showToastMessage(message: String, title: String) {
        var style = ToastStyle()
        style.messageColor = .white
        style.titleColor = .white
        self.view.makeToast(message, duration: 2.0, position: .center, title: title, image: UIImage(systemName: "x.circle.fill"), style: style, completion: nil)
    }
    
    func initCoordinates() {
        self.latitude = ""
        self.longitude = ""
    }
    
    
    
}
