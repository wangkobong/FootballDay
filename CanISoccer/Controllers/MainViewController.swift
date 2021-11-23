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
//    {
//        didSet {
//            let placeholderText = NSAttributedString(string: "주소를 입력해주세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
//            searchTextField.attributedPlaceholder = placeholderText
//        }
//    }
    
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
    @IBOutlet weak var assistantLabel: UILabel!
    
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
//        print("viewDidLoad: \(tasks!)")
        print("현재 unixTime: \(currentUnixtime)")

    }

    
    
    @IBAction func currentLocationBtnPressed(_ sender: UIButton) {
        print("currentLocationBtnPressed")
    }
    
    
    @IBAction func searchBtnPressed(_ sender: UIButton) {

        guard let address = self.searchTextField.text else { return }
    
        WeatherManager.shared.fetchGeocoding(address: address) { item in
            let x = item[0]["x"].stringValue
            let y = item[0]["y"].stringValue
            self.latitude = y
            self.longitude = x
        }

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {


            let isExisting = self.localRealm.objects(Forecast.self).filter("regDateData == \(self.todayOnlyDate!) && searchedLocationData == '\(address)'")

            if isExisting.isEmpty {

                WeatherManager.shared.fetchWeatherForecast(self.latitude, self.longitude){ list in
                    print(#function)
                    print("fetchWeatherForecast: \(address)")
                    print("selectedTime: \(self.selectedTime)")
                    for item in list {
                        let predictedTimeUnix = item["dt"].doubleValue
                        let predictedTimeData = Date().dateToString(unixTime: predictedTimeUnix)
                        let searchedLocation = address
                        let temp = item["main"]["temp"].doubleValue
                        let tempFeelsLike = item["main"]["feels_like"].doubleValue
                        let regDate = Date().onlyDate
                        let probabilityOfRain = item["pop"].doubleValue
                        let task = Forecast(predictedTimeUnixData: predictedTimeUnix, predictedTimeData: predictedTimeData, searchedLocationData: searchedLocation,tempData: temp, tempFeelsLikeData: tempFeelsLike, regDateData: Int(regDate)!, probabilityOfRain: floor(probabilityOfRain))
                        try! self.localRealm.write {
                            self.localRealm.add(task)
                        }
                    }
                    self.tasks = self.localRealm.objects(Forecast.self).filter("predictedTimeUnixData > \(self.currentUnixtime) && regDateData == \(self.todayOnlyDate!) && searchedLocationData == '\(address)'")
                    for task in self.tasks {
                        if task["predictedTimeUnixData"] as! Double > self.selectedTime {
                            let predictedTimeUnixDataByUser = task["predictedTimeUnixData"] as! Double
                            self.searchedTask = self.localRealm.objects(Forecast.self).filter("predictedTimeUnixData == \(predictedTimeUnixDataByUser) && searchedLocationData == '\(address)'")
                            print(self.searchedTask!)
                            break
                        }
                        
                    }
                }
                
            } else {
                print("이미 저장된 주소의 일기예보: \(address)")
                self.tasks = self.localRealm.objects(Forecast.self).filter("predictedTimeUnixData > \(self.currentUnixtime) && regDateData == \(self.todayOnlyDate!) && searchedLocationData == '\(address)'")
                for task in self.tasks {
                    //for문을 돌면서 selectedTime 보다 predictedTimeUnixData가 크면 멈춰서 해당하는 데이터가 있는 task를 가져온다
                    if task["predictedTimeUnixData"] as! Double > self.selectedTime {
                        let predictedTimeUnixDataByUser = task["predictedTimeUnixData"] as! Double
                        print(task["predictedTimeUnixData"]!)
                        self.searchedTask = self.localRealm.objects(Forecast.self).filter("predictedTimeUnixData == \(predictedTimeUnixDataByUser) && searchedLocationData == '\(address)'")
                        print(self.searchedTask!)
                        break
                    }
                    
                }
            }

            
            
            //       
            /*
             데이터 예측 시간, Unix, UTC : list.dt
            1.온도 : list.main.temp
             2. 체감온도 :list.main.feels_like
             3. 습도 : list.main.humidity
             4. list.weather.main
             5. list.weather.description
             6. 날씨아이콘 아아다 : list.weather.icon
             7. 강수확률 : list.pop
             8. 데이터 예측 시간 : list.dt_txt
             */
            
            //1. 데이터를 받아와서 당일 일기예보 12시, 15시, 18시, 21시, 24시 5개 DB에 저장 
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
            self.datePickerTextField.text = unixTimeToStirng
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
            let temperature = Int(temperatureData) - 273
            let condition = json["weather"][0]["main"].stringValue
            let conditiondId = json["weather"][0]["id"].stringValue
            let data = WeatherModel(conditionId: Int(conditiondId) ?? 0)
            self.temperatureLable.text = "\(temperature)"
            self.weatherStatusLabel.text = condition
            self.weatherStatusImageView.image = UIImage(systemName: data.conditionName)
//            let currentLocation = self.printLocality(lat, long)
            print(" didUpdateLocations currentLocation \(self.locality), \(self.thorughfare), ")
            self.searchTextField.text = "\(self.locality)"
 
        }
        locationManager?.stopUpdatingLocation()
        print(" didUpdateLocations CLLocationManagerDelegate \(self.locality), \(self.thorughfare)")
    }
}
