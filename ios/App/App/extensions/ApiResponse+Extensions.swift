//
//  ApiResponse+Extensions.swift
//  App
//
//  Created by Shahzaib Ali on 01/08/2024.
//

import Foundation

extension ApiResponse {
    private func convertStringToInt(_ string: String) -> Int? {
        // Convert the string to a Double
        if let doubleValue = Double(string) {
            // Convert the Double to an Int
            return Int(doubleValue)
        }
        // Return nil if the conversion fails
        return nil
    }
    func getWeatherSymbol() -> Int {
        return runCatching {
            return convertStringToInt(getValueForParam(param: "weather_symbol_1h:idx")) ?? 0
        } ?? 0
    }

    func getValueForParam(param: String) -> String {
        guard let data = self.data?.data?[0].parameters else {
            return ""
        }

        for entry in data {
            if entry.parameter == param {
                return String(entry.value!)
            }
        }
        return ""
    }

    func getCurrentTemp() -> String {
        return getValueForParam(param: "t_2m:C")
    }

    func getWindSpeed() -> String {
        return getValueForParam(param: "wind_speed_10m:kmh")
    }

    func getCurrentFeelLikeTemp() -> String {
        return getValueForParam(param: "t_apparent:C")
    }

    func get24hHighTemp() -> String {
        return getFirstCoordinatedValueForParam(param: "t_max_2m_24h:C").value
    }

    func get24LowTemp() -> String {
        return getFirstCoordinatedValueForParam(param: "t_min_2m_24h:C").value
    }

    func get24WindSpeed() -> String {
        return getFirstCoordinatedValueForParam(param: "wind_speed_2m:kmh").value
    }

    func get24WindDirectionAngle() -> String {
        return getFirstCoordinatedValueForParam(param: "wind_dir_2m:d").value
    }

    func get24Precip() -> String {
        return getFirstCoordinatedValueForParam(param: "precip_24h:mm").value
    }

    func get24PrecipProbability() -> String {
        return getFirstCoordinatedValueForParam(param: "prob_precip_24h:p").value
    }

    func get6hoursForeCastTemp() -> [WeatherDate] {
        return getListCoordinatedValueForParam(param: "t_2m:C")
    }

    func get6hoursForeCastIcons() -> [WeatherDate] {
        return getListCoordinatedValueForParam(param: "weather_symbol_1h:idx")
    }

    func get5DaysForeCastIcons() -> [WeatherDate] {
        return getListCoordinatedValueForParam(param: "weather_symbol_24h:idx")
    }

    func get5DaysForeCastHighTemp() -> [WeatherDate] {
        return getListCoordinatedValueForParam(param: "t_max_2m_24h:C")
    }

    func get5DaysForeCastLowTemp() -> [WeatherDate] {
        return getListCoordinatedValueForParam(param: "t_min_2m_24h:C")
    }

    private func getListCoordinatedValueForParam(param: String) -> [WeatherDate] {
       
        guard let data = self.data?.data else {
            return []
        }
    
        for entry in data {
            if entry.parameter == param {
                return entry.coordinates?.first?.dates ?? []
            }
        }
        return []
    }

    private func getFirstCoordinatedValueForParam(param: String) -> (date: String, value: String) {
       
        guard let data = self.data?.data else {
            return ("", "")
        }

        for entry in data {
            if entry.parameter == param {
                if let firstDate = entry.coordinates?.first?.dates?.first {
                    return (firstDate.date ?? "", String(firstDate.value!))
                }
            }
        }
        return ("", "")
    }

    // Helper method to simulate `kotlin.runCatching`
    private func runCatching<T>(_ block: () throws -> T) -> T? {
        do {
            return try block()
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
}
