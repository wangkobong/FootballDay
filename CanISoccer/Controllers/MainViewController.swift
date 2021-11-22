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

class MainViewController: UIViewController {
    
    var locationManager: CLLocationManager?
    var latitude = ""
    var longitude = ""
    var locality = ""
    var thorughfare = ""
    var currentTimestamp: Int64 = 0

    var currentLocation:CLLocationCoordinate2D!
    
    @IBOutlet weak var searchTextField: UITextField!{
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
    @IBOutlet weak var assistantLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.datePickerTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone))
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.startUpdatingLocation()

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
            print("searchBtnPressed  \(self.latitude), \(self.longitude)")
            WeatherManager.shared.fetchWeatherForecast(self.latitude, self.longitude)
            
            // 디스패치그룹
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
    

    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
    }
    
    @objc func tapDone() {
        if let datePicker = self.datePickerTextField.inputView as? UIDatePicker { // 2-1
            let selectedTime = datePicker.date.timeIntervalSince1970
            let unixTimeToStirng = Date().setTimestamp(unixTime: selectedTime)
            print("selectedTime: \(selectedTime)")
            print("unixTimeToStirng: \(unixTimeToStirng)")
//            let dateformatter = DateFormatter() // 2-2
//            dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//            dateformatter.dateFormat = "HH:mm"
//            dateformatter.timeStyle = .short
            self.datePickerTextField.text = unixTimeToStirng //2-4
        }
        self.datePickerTextField.resignFirstResponder() // 2-5
    }
    

}


// MARK: - CLLocationManagerDelegate
extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        guard let coordinates = locations.last?.coordinate else { return }
        let lat = coordinates.latitude
        let long = coordinates.longitude
        let test = self.printLocality(lat, long)
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
