//
//  ApiResponse.swift
//  App
//
//  Created by Shahzaib Ali on 01/08/2024.
//

import Foundation

struct ApiResponse: Codable {
    var success: Bool? = nil
    var data: WeatherDataContainer? = nil
}

struct WeatherDataContainer: Codable {
    var version: String? = nil
    var user: String? = nil
    var dateGenerated: String? = nil
    var status: String? = nil
    var data: [WeatherParameter]? = nil
}

struct WeatherParameter: Codable {
    
    var parameter: String? = nil
    var parameters: [Parameter]? = nil
    var value: Double? = 0.0
    var coordinates: [WeatherCoordinate]? = nil
    
    
}

struct Parameter: Codable {
    var parameter: String? = nil
    var value: Double? = 0.0
}

struct WeatherCoordinate: Codable {
    var lat: Double? = nil
    var lon: Double? = nil
    var dates: [WeatherDate]? = nil
}

struct WeatherDate: Codable {
    var date: String? = nil
    var value: Double?  = nil
}
