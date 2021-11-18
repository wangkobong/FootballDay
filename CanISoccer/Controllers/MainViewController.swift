//
//  ViewController.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2021/11/15.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

