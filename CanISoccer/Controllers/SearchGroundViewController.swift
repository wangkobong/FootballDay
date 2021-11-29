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

class SearchGroundViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        WeatherManager.shared.fetchSearchPlaces()
        
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        print("locationButtonPressed")
    }
    
}
