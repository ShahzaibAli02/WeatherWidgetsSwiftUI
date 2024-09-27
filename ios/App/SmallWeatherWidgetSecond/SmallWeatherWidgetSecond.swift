//
//  SmallWeatherWidgetSecond.swift
//  SmallWeatherWidgetSecond
//
//  Created by Shahzaib Ali on 02/08/2024.
//

import WidgetKit
import SwiftUI


struct SmallWeatherWidgetSecondEntryView : View {
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
                SmallWeatherViewB(weather: weather)
            }
            
            
            
            
            
        }.overlay(alignment: .topTrailing){
            Image("top_lines_widget_1")
                .resizable()
                .aspectRatio(contentMode: .fill) // This will crop the
                .frame(width: 50, height: 50)
        }
    }
    
    
}


struct SmallWeatherWidgetSecond: Widget {
    let kind: String = "SmallWeatherWidgetSecond"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                SmallWeatherWidgetSecondEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                SmallWeatherWidgetSecondEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("WeatherWidget Second")
        .description("This is WeatherWidget Second.")
        .contentMarginsDisabled()
        .supportedFamilies([.systemSmall])
    }
}


struct WeatherView_Previews: PreviewProvider {
    static var mWeather: Weather = {
        var weather = Weather()
        weather.currentTemperature = "32"
        weather.cityName = "Islamabad"
        weather._24hHighTemp = "25"
        weather._24LowTemp = "23"
        weather.weatherSymbol=1
        return weather
    }()
    static var previews: some View {
        
        SmallWeatherViewB(weather: mWeather)
        
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        
    }
}
#Preview(as: .systemSmall) {
    SmallWeatherWidgetSecond()
} timeline: {
    WeatherData(date: .now)
}
