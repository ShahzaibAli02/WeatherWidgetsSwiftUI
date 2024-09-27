//
//  MediumWeatherWidget.swift
//  MediumWeatherWidget
//
//  Created by Shahzaib Ali on 03/08/2024.
//

import WidgetKit
import SwiftUI


struct MediumWeatherWidgetEntryView : View {
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
                MediumWeatherView(weather: weather)
                    .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .topLeading)
                    .padding(EdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10))
            }
            
            
            
            
            
        }.overlay(alignment: .top){
            Image("top_line_medium")
                .resizable()
                .aspectRatio(contentMode: .fill) // This will crop the
                .frame(width: 100, height: 50)
        }
    }
    
}

struct MediumWeatherWidget: Widget {
    let kind: String = "MediumWeatherWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                MediumWeatherWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                MediumWeatherWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("MediumWeather Widget")
        .description("This is an MediumWeather Widget.")
        .contentMarginsDisabled()
        .supportedFamilies([.systemMedium])
    }
}

#Preview(as: .systemSmall) {
    MediumWeatherWidget()
} timeline: {
    WeatherData(date: .now)
}
