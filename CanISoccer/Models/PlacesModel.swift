//
//  PlacesModel.swift
//  CanISoccer
//
//  Created by sungyeon kim on 2021/11/29.
//

import Foundation

class Places {
    var placeName: String
    var address: String
    var phone: String
    var placeURL: String
    var latitude: String
    var longitude: String
    
    init(placeName: String, address: String, phone: String, placeURL: String, latitude: String, longitude: String) {
        self.placeName = placeName
        self.address = address
        self.phone = phone
        self.placeURL = placeURL
        self.latitude = latitude
        self.longitude = longitude
    }
}

