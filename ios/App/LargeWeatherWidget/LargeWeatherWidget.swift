//
//  LargeWeatherWidget.swift
//  LargeWeatherWidget
//
//  Created by Shahzaib Ali on 03/08/2024.
//

import WidgetKit
import SwiftUI



struct LargeWeatherWidgetEntryView : View {
    var entry: WeatherData
    var weather:Weather
    init(entry: WeatherData) {
        self.entry = entry
        if let data = entry.data?.data as? Weather {
            self.weather = data
        } else {
            // Handle the case where data is nil or not of type Weather
            self.weather = Weather() // or provide a default Weather instance
        }
    }
    
    var body: some View {
        ZStack(){
            
            LinearGradient(gradient: Gradient(colors: [Color(hex: "#00A3E2"), Color(hex: "#0854BC")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all) // Ensure the gradient covers the entire area
            
            
            if(entry.data?.errorCode != -1)
            {
               
                ErrorView(errorImage: entry.data?.errorIconName ?? "error", errorMessage: entry.data?.message.toLocalizedString() ?? "unknown_error".toLocalizedString()
                )
                
            }
            else {
                LargeWeatherView(weather: weather).frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .topLeading).padding(EdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10))
            }
            
            
            
            
            
        }.overlay(alignment: .top){
            Image("top_line_medium")
                .resizable()
                .aspectRatio(contentMode: .fill) // This will crop the
                .frame(width: 100, height: 50)
        }
    }
    
}

struct LargeWeatherWidget: Widget {
    let kind: String = "LargeWeatherWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                LargeWeatherWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                LargeWeatherWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("LargeWeather Widget")
        .description("This is an LargeWeather Widget.")
        .contentMarginsDisabled()
        .supportedFamilies([.systemLarge])
    }
}

#Preview(as: .systemSmall) {
    LargeWeatherWidget()
} timeline: {
    WeatherData(date: .now)
}
