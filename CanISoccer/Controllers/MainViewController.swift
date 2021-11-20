//
//  ViewController.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2021/11/15.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainViewController: UIViewController {
    

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.datePickerTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone))
    }
    
    
    @IBAction func currentLocationBtnPressed(_ sender: UIButton) {
        print("currentLocationBtnPressed")
    }
    
    
    @IBAction func searchBtnPressed(_ sender: UIButton) {
        if let address = searchTextField.text {
            fetchGeocoding(address: address)
        }

        print("searchBtnPressed")
    }
    
    func fetchGeocoding(address: String) {
        print(address)
        if let query = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            print(query)
            let url = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=\(query)"
            let clientID = Bundle.main.naverAPIKEYID
            let clientSecret = Bundle.main.naverAPIKEY
            let header: HTTPHeaders = [
                "X-NCP-APIGW-API-KEY-ID": clientID,
                "X-NCP-APIGW-API-KEY": clientSecret
            ]
            
            AF.request(url, method: .get, headers: header).validate().responseJSON { response in
                switch response.result {
                case.success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                case.failure(let error):
                    print(error)
                }
            }
            
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
    }
    
    @objc func tapDone() {
        if let datePicker = self.datePickerTextField.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateFormat = "HH:mm"
//            dateformatter.timeStyle = .short
            self.datePickerTextField.text = dateformatter.string(from: datePicker.date) //2-4
        }
        self.datePickerTextField.resignFirstResponder() // 2-5
    }
    

}
