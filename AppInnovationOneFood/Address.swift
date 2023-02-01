//
//  Address.swift
//  AppInnovationOneFood
//
//  Created by Eduardo Alexandre on 01/02/23.
//

import Foundation
import Contacts
import CoreLocation

struct Address {
    var name: String
    var placemark: CLPlacemark
    var postalAddress: CNPostalAddress
    
    init(name: String, placemark: CLPlacemark, postalAddress: CNPostalAddress) {
        self.name = name
        self.placemark = placemark
        self.postalAddress = postalAddress
    }
}
