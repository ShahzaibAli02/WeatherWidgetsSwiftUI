//
//  Provider.swift
//  App
//
//  Created by Shahzaib Ali on 03/08/2024.
//

import Foundation
import WidgetKit
import SwiftUI
import CoreLocation

struct Provider: TimelineProvider {    
    func placeholder(in context: Context) -> WeatherData {
        WeatherData(date: Date(),data:Result(data: Constants.placeHolderWeather))
    }
    
    func getSnapshot(in context: Context, completion: @escaping (WeatherData) -> ()) {
        let entry = WeatherData(date: Date(),data:Result(data: Constants.placeHolderWeather))
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            var entries: [WeatherData] = []
            let strLocation = "33.6461824,73.0497024"
            let weather =  await WidgetDataManager.getWeather(strLocation: strLocation)
            let currentDate = Date()
            let entryDate = currentDate
            var weatherData = WeatherData(date: entryDate)
            weatherData.data = weather
            entries.append(weatherData)
            
            // Set the timeline policy to refresh after 5 minutes.
            let timeline = Timeline(entries: entries, policy: .after(Calendar.current.date(byAdding: .minute, value: 5, to: currentDate)!))
            completion(timeline)
        }
        
    }
}
