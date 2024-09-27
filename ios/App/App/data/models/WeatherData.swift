//
//  WeatherData.swift
//  SmallWeatherWidgetFirstExtension
//
//  Created by Shahzaib Ali on 01/08/2024.
//

import Foundation
import CoreLocation
import WidgetKit
struct WeatherData: TimelineEntry {
    var date: Date
    
    var data:Result<Weather?>? = nil
    
//
//    var cityName : String? = nil
//    var currentTemperature: String? = nil
//    var currentFeelLikeTemp: String? = nil
//    var windSpeed: String? = nil
//    var _24hHighTemp: String? = nil
//    var _24LowTemp: String? = nil
//    var _24WindSpeed: String? = nil
//    var _24WindDirection: String? = nil
//    var _24Precip: String? = nil
//    var _24PrecipProb: String? = nil
//    var weatherSymbol: Int? = 0
//    var _6hoursForeCastTemp: [WeatherDate]? = nil
//    var _6hoursForeCastIcons: [WeatherDate]? = nil
//    var _5DaysForeCastIcons: [WeatherDate]? = nil
//    var _5DaysForeCastHighTemp: [WeatherDate]? = nil
//    var _5DaysForeCastLowTemp: [WeatherDate]? = nil
//    
//    
//    mutating func copy(weather:Weather)
//    {
//        self.cityName = weather.cityName
//        self.currentTemperature = weather.currentTemperature
//        self.currentFeelLikeTemp = weather.currentFeelLikeTemp
//        self.windSpeed = weather.windSpeed
//        self._24hHighTemp = weather._24hHighTemp
//        self._24LowTemp = weather._24LowTemp
//        self._24WindSpeed = weather._24WindSpeed
//        self._24WindDirection = weather._24WindDirection
//        self._24Precip = weather._24Precip
//        self._24PrecipProb = weather._24PrecipProb
//        self.weatherSymbol = weather.weatherSymbol
//        self._6hoursForeCastTemp = weather._6hoursForeCastTemp
//        self._6hoursForeCastIcons = weather._6hoursForeCastIcons
//        self._5DaysForeCastIcons = weather._5DaysForeCastIcons
//        self._5DaysForeCastHighTemp = weather._5DaysForeCastHighTemp
//        self._5DaysForeCastLowTemp = weather._5DaysForeCastLowTemp
//    }
    
}
