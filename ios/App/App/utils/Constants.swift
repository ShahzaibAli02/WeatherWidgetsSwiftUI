//
//  Constants.swift
//  App
//
//  Created by Shahzaib Ali on 01/08/2024.
//

import Foundation
import SwiftUI


// Assuming you have a structure for WeatherSymbol similar to the Kotlin one
struct WeatherSymbol {
    let description: String
    let imageName: String
}

struct Constants {
//    // TIME FOR WIDGET TO UPDATE IN MILLISECONDS
//    static let WIDGET_UPDATE_TIME: TimeInterval = (10 * 60 * 1000)
//    
//    // Time after get new location 10 minutes
//    static let LOCATION_UPDATE_TIME: TimeInterval = (10 * 60 * 1000)
    
    static let PARAM_CITY = "city"
    static let PARAM_LOCATION = "location"
    static let PARAM_ERROR_CODE = "error_code"
    static let PARAM_ERROR_MESSAGE = "error_message"
    static let PARAM_ERROR_DESCRIPTION = "error_description"
    static let PARAM_ERROR_ICON = "error_icon"
    
    static let PARAM_WEATHER = "weather"
    
    // ERROR CODES
    static let ERROR_LOCATION = 11
    static let ERROR_LOCATION_PERMISSION = 12
    static let ERROR_GPS_DISABLED = 13
    static let ERROR_API = 14
    static let ERROR_NO_INTERNET = 16
    static let ERROR_EXCEPTION = 15
    
    // Weather white icons data
    static let weatherWhiteIconsData: [Int: WeatherSymbol] = [
        0: WeatherSymbol(description: "nan", imageName: "white_0"),
        1: WeatherSymbol(description: "nan", imageName: "white_1"),
        2: WeatherSymbol(description: "nan", imageName: "white_2"),
        3: WeatherSymbol(description: "nan", imageName: "white_3"),
        4: WeatherSymbol(description: "nan", imageName: "white_4"),
        5: WeatherSymbol(description: "nan", imageName: "white_5"),
        6: WeatherSymbol(description: "nan", imageName: "white_6"),
        7: WeatherSymbol(description: "nan", imageName: "white_7"),
        8: WeatherSymbol(description: "nan", imageName: "white_8"),
        9: WeatherSymbol(description: "nan", imageName: "white_9"),
        10: WeatherSymbol(description: "nan", imageName: "white_10"),
        11: WeatherSymbol(description: "nan", imageName: "white_11"),
        12: WeatherSymbol(description: "nan", imageName: "white_12"),
        13: WeatherSymbol(description: "nan", imageName: "white_13"),
        14: WeatherSymbol(description: "nan", imageName: "white_14"),
        15: WeatherSymbol(description: "nan", imageName: "white_15"),
        16: WeatherSymbol(description: "nan", imageName: "white_16"),
        101: WeatherSymbol(description: "nan", imageName: "white_101"),
        102: WeatherSymbol(description: "nan", imageName: "white_102"),
        103: WeatherSymbol(description: "nan", imageName: "white_103"),
        104: WeatherSymbol(description: "nan", imageName: "white_104"),
        105: WeatherSymbol(description: "nan", imageName: "white_105"),
        106: WeatherSymbol(description: "nan", imageName: "white_106"),
        107: WeatherSymbol(description: "nan", imageName: "white_107"),
        108: WeatherSymbol(description: "nan", imageName: "white_108"),
        109: WeatherSymbol(description: "nan", imageName: "white_109"),
        110: WeatherSymbol(description: "nan", imageName: "white_110"),
        111: WeatherSymbol(description: "nan", imageName: "white_111"),
        112: WeatherSymbol(description: "nan", imageName: "white_112"),
        113: WeatherSymbol(description: "nan", imageName: "white_113"),
        114: WeatherSymbol(description: "nan", imageName: "white_114"),
        115: WeatherSymbol(description: "nan", imageName: "white_115"),
        116: WeatherSymbol(description: "nan", imageName: "white_116")
    ]
    
    // Weather data
    // Weather data
    static let weatherData: [Int: WeatherSymbol] = [
        0: WeatherSymbol(description: NSLocalizedString("weather_code_not_determined", comment: ""), imageName: "baseline_broken_image_24"),
        1: WeatherSymbol(description: NSLocalizedString("clear_sky", comment: ""), imageName: "_1"),
        101: WeatherSymbol(description: NSLocalizedString("clear_sky", comment: ""), imageName: "_101"),
        2: WeatherSymbol(description: NSLocalizedString("light_clouds", comment: ""), imageName: "_2"),
        102: WeatherSymbol(description: NSLocalizedString("light_clouds", comment: ""), imageName: "_102"),
        3: WeatherSymbol(description: NSLocalizedString("partly_cloudy", comment: ""), imageName: "_3"),
        103: WeatherSymbol(description: NSLocalizedString("partly_cloudy", comment: ""), imageName: "_103"),
        4: WeatherSymbol(description: NSLocalizedString("cloudy", comment: ""), imageName: "_4"),
        104: WeatherSymbol(description: NSLocalizedString("cloudy", comment: ""), imageName: "_104"),
        5: WeatherSymbol(description: NSLocalizedString("rain", comment: ""), imageName: "_5"),
        105: WeatherSymbol(description: NSLocalizedString("rain", comment: ""), imageName: "_105"),
        6: WeatherSymbol(description: NSLocalizedString("rain_and_snow_sleet", comment: ""), imageName: "_6"),
        106: WeatherSymbol(description: NSLocalizedString("rain_and_snow_sleet", comment: ""), imageName: "_106"),
        7: WeatherSymbol(description: NSLocalizedString("snow", comment: ""), imageName: "_7"),
        107: WeatherSymbol(description: NSLocalizedString("snow", comment: ""), imageName: "_107"),
        8: WeatherSymbol(description: NSLocalizedString("rain_shower", comment: ""), imageName: "_8"),
        108: WeatherSymbol(description: NSLocalizedString("rain_shower", comment: ""), imageName: "_108"),
        9: WeatherSymbol(description: NSLocalizedString("snow_shower", comment: ""), imageName: "_9"),
        109: WeatherSymbol(description: NSLocalizedString("snow_shower", comment: ""), imageName: "_109"),
        10: WeatherSymbol(description: NSLocalizedString("sleet_shower", comment: ""), imageName: "_10"),
        110: WeatherSymbol(description: NSLocalizedString("sleet_shower", comment: ""), imageName: "_110"),
        11: WeatherSymbol(description: NSLocalizedString("light_fog", comment: ""), imageName: "_11"),
        111: WeatherSymbol(description: NSLocalizedString("light_fog", comment: ""), imageName: "_111"),
        12: WeatherSymbol(description: NSLocalizedString("dense_fog", comment: ""), imageName: "_12"),
        112: WeatherSymbol(description: NSLocalizedString("dense_fog", comment: ""), imageName: "_112"),
        13: WeatherSymbol(description: NSLocalizedString("freezing_rain", comment: ""), imageName: "_13"),
        113: WeatherSymbol(description: NSLocalizedString("freezing_rain", comment: ""), imageName: "_113"),
        14: WeatherSymbol(description: NSLocalizedString("thunderstorms", comment: ""), imageName: "_14"),
        114: WeatherSymbol(description: NSLocalizedString("thunderstorms", comment: ""), imageName: "_114"),
        15: WeatherSymbol(description: NSLocalizedString("drizzle", comment: ""), imageName: "_15"),
        115: WeatherSymbol(description: NSLocalizedString("drizzle", comment: ""), imageName: "_115"),
        16: WeatherSymbol(description: NSLocalizedString("sandstorm", comment: ""), imageName: "_16"),
        116: WeatherSymbol(description: NSLocalizedString("sandstorm", comment: ""), imageName: "_116")
    ]
    
    
    
    struct Fonts {
//        static let roboto = "regular".toLocalizedString()
//        static let robotoBold = "bold".toLocalizedString()
//        static let robotoRegular = "regular".toLocalizedString()
//        static let robotoMedium = "medium".toLocalizedString()
        
        
        static let roboto = "regular"
        static let robotoBold = "bold"
        static let robotoRegular = "regular"
        static let robotoMedium = "medium"
    }
    
    struct Colors {
        static let primaryColor = Color(hex: "#00A3E2")
        static let secondaryColor = Color(hex: "#0854BC")
    }
    
    
    
    
    static var placeHolderWeather: Weather = {
        var weather = Weather()
        weather.currentTemperature = "32"
        weather.currentFeelLikeTemp = "33"
        weather.cityName = "Islamabad"
        weather._24hHighTemp = "25"
        weather._24LowTemp = "23"
        weather._24Precip = "0.02"
        weather._24PrecipProb = "70"
        weather._24WindSpeed = "12"
        weather._24WindDirection = "45"
        
        weather._6hoursForeCastTemp = [WeatherDate(date:"2024-07-25T19:00:00Z",value: 32),WeatherDate(date:"2024-07-25T19:00:00Z",value: 32),WeatherDate(date:"2024-07-25T19:00:00Z",value: 32),WeatherDate(date:"2024-07-25T19:00:00Z",value: 32),WeatherDate(date:"2024-07-25T19:00:00Z",value: 32),WeatherDate(date:"2024-07-25T19:00:00Z",value: 32)]
        weather._6hoursForeCastIcons = [WeatherDate(date:"2024-07-25T19:00:00Z",value: 32),WeatherDate(date:"2024-07-25T19:00:00Z",value: 32),WeatherDate(date:"2024-07-25T19:00:00Z",value: 32),WeatherDate(date:"2024-07-25T19:00:00Z",value: 32),WeatherDate(date:"2024-07-25T19:00:00Z",value: 32),WeatherDate(date:"2024-07-25T19:00:00Z",value: 32)]
        weather._5DaysForeCastHighTemp = [WeatherDate(date:"2024-07-25T19:00:00Z",value: 32),WeatherDate(date:"2024-07-25T19:00:00Z",value: 32),WeatherDate(date:"2024-07-25T19:00:00Z",value: 32),WeatherDate(date:"2024-07-25T19:00:00Z",value: 32),WeatherDate(date:"2024-07-25T19:00:00Z",value: 32),WeatherDate(date:"2024-07-25T19:00:00Z",value: 32)]
        weather._5DaysForeCastLowTemp = [WeatherDate(date:"2024-07-25T19:00:00Z",value: 32),WeatherDate(date:"2024-07-25T19:00:00Z",value: 32),WeatherDate(date:"2024-07-25T19:00:00Z",value: 32),WeatherDate(date:"2024-07-25T19:00:00Z",value: 32),WeatherDate(date:"2024-07-25T19:00:00Z",value: 32),WeatherDate(date:"2024-07-25T19:00:00Z",value: 32)]
        
        weather._5DaysForeCastIcons = [WeatherDate(date:"2024-07-25T19:00:00Z",value: 1),WeatherDate(date:"2024-07-25T19:00:00Z",value: 1),WeatherDate(date:"2024-07-25T19:00:00Z",value: 1),WeatherDate(date:"2024-07-25T19:00:00Z",value: 1),WeatherDate(date:"2024-07-25T19:00:00Z",value: 1),WeatherDate(date:"2024-07-25T19:00:00Z",value: 1)]
        
        weather.weatherSymbol=1
        return weather
    }()
    
}
