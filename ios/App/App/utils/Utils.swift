//
//  Utils.swift
//  App
//
//  Created by Shahzaib Ali on 02/08/2024.
//

import Foundation
import CoreLocation

struct Utils{
    
    static func strToLocation(from string: String?) -> CLLocation? {
        if string == nil {
            return nil
        }
             
        let components = string!.split(separator: ",")
        guard components.count == 2,
              let latitude = Double(components[0]),
              let longitude = Double(components[1]) else {
            return nil
        }
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    static func direction(from angleString: String?) -> String {
        // Convert the string to a Double
        if angleString == nil {
            return ""
        }
        guard let angle = Double(angleString!) else {
            return ""
        }
        
        // Determine the direction based on the angle
        if angle <= 22.5 {
            return "angle_N".toLocalizedString()
        } else if angle <= 67.5 {
            return "angle_NW".toLocalizedString()
        } else if angle <= 112.5 {
            return "angle_W".toLocalizedString()
        } else if angle <= 157.5 {
            return "angle_SW".toLocalizedString()
        } else if angle <= 202.5 {
            return "angle_S".toLocalizedString()
        } else if angle <= 247.5 {
            return "angle_SE".toLocalizedString()
        } else if angle <= 292.5 {
            return "angle_E".toLocalizedString()
        } else if angle <= 337.5 {
            return "angle_NE".toLocalizedString()
        } else {
            return "angle_N".toLocalizedString()
        }
    }
    static func getCurrentIndex(_6hoursForeCastTemp: [WeatherDate]?) ->  Int
      {
          let currentAMPM = DateTime.shared.currentAmPm()
          
          for i in 0...(_6hoursForeCastTemp?.count ?? 0){
              
              let it  = _6hoursForeCastTemp![i]
              let amPM=DateTime.shared.convertToAmPm(dateString: it.date)
              if amPM == currentAMPM{
                  return i
              }
                  
          }
        
          return 0
      }
    
    
    static func getWhiteWeatherIcon(dateValue: WeatherDate?) -> String {
          
          guard let value =  dateValue?.value else {
              return "white_0"
          }
        return Constants.weatherWhiteIconsData[Int(value)]?.imageName ?? "white_0"
    
      }
    
}

