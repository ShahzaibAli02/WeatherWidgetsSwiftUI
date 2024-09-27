//
//  Weather.swift
//  App
//
//  Created by Shahzaib Ali on 01/08/2024.
//

import Foundation
struct Weather {
    var currentTemperature: String? = nil
    var currentFeelLikeTemp: String? = nil
    var windSpeed: String? = nil
    var cityName: String = ""
    var _24hHighTemp: String? = nil
    var _24LowTemp: String? = nil
    var _24WindSpeed: String? = nil
    var _24WindDirection: String? = nil
    var _24Precip: String? = nil
    var _24PrecipProb: String? = nil
    var weatherSymbol: Int? = 0
    var _6hoursForeCastTemp: [WeatherDate]? = nil
    var _6hoursForeCastIcons: [WeatherDate]? = nil
    var _5DaysForeCastIcons: [WeatherDate]? = nil
    var _5DaysForeCastHighTemp: [WeatherDate]? = nil
    var _5DaysForeCastLowTemp: [WeatherDate]? = nil
    
}
