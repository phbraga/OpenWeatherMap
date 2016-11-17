//
//  City.swift
//  OpenWeatherMap
//
//  Created by Pedro Magalhaes on 14/11/16.
//  Copyright © 2016 PHMB. All rights reserved.
//

import UIKit

class City: NSObject {
    
    var name: String?
    var maxTemperature: Double?
    var minTemperature: Double?
    var weatherDescription: String?
    
    init(_ map: [String: Any]) {
        self.name = map["name"] as! String?
        
        if let mainEntry = map["main"] as? [String: Any] {
            if let minTemperature = mainEntry["temp_min"] as? Double! {
                self.minTemperature = minTemperature! - 273.0
            }
            if let maxTemperature = mainEntry["temp_max"] as? Double! {
                self.maxTemperature = maxTemperature! - 273.0
            }
        }
        
        if let weatherEntry = map["weather"] as? NSArray {
            if let weatherDescription = weatherEntry[0] as? [String: Any] {
                self.weatherDescription = weatherDescription["description"] as? String
            }
        }
    }
}
