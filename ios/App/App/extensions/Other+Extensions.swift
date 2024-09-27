//
//  Other+Extensions.swift
//  SmallWeatherWidgetFirstExtension
//
//  Created by Shahzaib Ali on 01/08/2024.
//

import Foundation
import CoreLocation

extension CLLocation {
    func getCityName() async -> String {
        let geocoder = CLGeocoder()
        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(self)
            if let placemark = placemarks.first {
                return placemark.locality ?? ""
            } else {
                return ""
            }
        } catch {
            print("Error in reverse geocoding: \(error.localizedDescription)")
            return ""
        }
    }
}


extension String{
    
    func roundedStringValue() -> String {
        
        
           guard let number = Double(self) else {
               // If conversion fails, return an empty string
               return ""
           }
           
           // Round the number to the nearest integer
           let rounded = Int(round(number))
           
           // Convert the rounded integer back to a string
           return "\(rounded)"
       }
    func toLocalizedString() ->String {
        
        return NSLocalizedString(self, comment: "")
    }
    
}
extension Double? {
    
    func roundedStringValue() -> String {
        
        
           guard let number = self else {
               // If conversion fails, return an empty string
               return ""
           }
           
           // Round the number to the nearest integer
           let rounded = Int(round(number))
           
           // Convert the rounded integer back to a string
           return "\(rounded)"
       }

}
extension String? {
    
    func roundedStringValue() -> String {
        
        
           guard let number = Double(value()) else {
               // If conversion fails, return an empty string
               return ""
           }
           
           // Round the number to the nearest integer
           let rounded = Int(round(number))
           
           // Convert the rounded integer back to a string
           return "\(rounded)"
       }
    func value() -> String {
        if let text: String = self {
          return text
        }
        return ""
    }
}
