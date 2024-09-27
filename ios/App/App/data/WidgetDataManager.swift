//
//  WidgetDataManager.swift
//  App
//
//  Created by Shahzaib Ali on 02/08/2024.
//

import Foundation
import CoreLocation



struct WidgetDataManager {
    
    private static let TAG = "WidgetDataManager"
    static func getWeather(strLocation : String?) async -> Result<Weather?> {
 
        
        let location = Utils.strToLocation(from: strLocation!)
        if location == nil {
            return Result(errorCode: Constants.ERROR_LOCATION,errorIconName: "ic_location",message: "enable_location_access",description: "")
        }
        
        let cityName = await location!.getCityName()
        
        
        let currentTimeApiResponse =  await  ApiHandler().loadRouteQueryApi(parameters: [
            "parameters": [
                "weather_symbol_1h:idx",
                "t_2m:C",
                "t_apparent:C"
            ],
            "location": [
                strLocation
            ],
            "date": DateTime.shared.currentDateTimeActual,
        ])
        
        
        let dailyApiResponse =  await  ApiHandler().loadPublicQuery(parameters: [
            "parameters": [
                "weather_symbol_24h:idx",
                "t_max_2m_24h:C",
                "t_min_2m_24h:C",
                "wind_speed_2m:kmh",
                "wind_dir_2m:d",
                "precip_24h:mm",
                "prob_precip_24h:p"
            ],
            "resolution": "PT24H",
            "startdate": DateTime.shared.currentDateTime,
            "enddate": DateTime.shared.addDays(days: 5),
            "coordinate":strLocation!,
            "model":"mix",
            "format": "json",
            "lang": "en"
        ])
        
        
        let hourlyTimeApiResponse =  await  ApiHandler().loadPublicQuery(parameters: [
            "parameters": [
                "weather_symbol_1h:idx",
                "t_2m:C",
            ],
            "resolution": "PT1H",
            "startdate": DateTime.shared.currentDateTime,
            "enddate": DateTime.shared.addDays(days: 2),
            "coordinate":strLocation!,
            "model":"mix",
            "format": "json",
            "lang": "en"
        ])
        
        
        if (currentTimeApiResponse.errorCode != -1) || (dailyApiResponse.errorCode != -1) || (currentTimeApiResponse.errorCode != -1) {
            return Result(errorCode: Constants.ERROR_API,errorIconName: "error", message: "check_internet_connection", description: "")
        }
        
        
        
        var weather = Weather()
        weather.weatherSymbol = currentTimeApiResponse.data??.getWeatherSymbol()
        weather.currentTemperature = currentTimeApiResponse.data??.getCurrentTemp()
        weather.currentFeelLikeTemp = currentTimeApiResponse.data??.getCurrentFeelLikeTemp()
        weather.windSpeed = currentTimeApiResponse.data??.getWindSpeed()
        weather._24hHighTemp = dailyApiResponse.data??.get24hHighTemp()
        weather._24LowTemp = dailyApiResponse.data??.get24LowTemp()
        weather._24Precip = dailyApiResponse.data??.get24Precip()
        weather._24PrecipProb = dailyApiResponse.data??.get24PrecipProbability()
        weather._24WindDirection = dailyApiResponse.data??.get24WindDirectionAngle()
        
        weather._24WindSpeed = dailyApiResponse.data??.get24WindSpeed()
       
        
        
        weather._6hoursForeCastTemp = hourlyTimeApiResponse.data??.get6hoursForeCastTemp()
        weather._6hoursForeCastIcons = hourlyTimeApiResponse.data??.get6hoursForeCastIcons()


        weather._5DaysForeCastIcons = dailyApiResponse.data??.get5DaysForeCastIcons()
        weather._5DaysForeCastHighTemp = dailyApiResponse.data??.get5DaysForeCastHighTemp()
        weather._5DaysForeCastLowTemp = dailyApiResponse.data??.get5DaysForeCastLowTemp()
        
        weather.cityName = cityName
        
        
        return Result(data: weather)
        
        
    }
    
}
