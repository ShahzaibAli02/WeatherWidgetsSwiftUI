//
//  SmallWeatherWidgetFirst.swift
//  SmallWeatherWidgetFirst
//
//  Created by Shahzaib Ali on 31/07/2024.
//

import WidgetKit
import SwiftUI
import CoreLocation


struct SmallWeatherWidgetFirstEntryView : View {
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
                SmallWeatherViewA(weather: weather)
            }
            
            
            
            
            
        }
        .overlay(alignment: .topTrailing){
            Image(NSLocalizedString("top_lines_widget", comment: ""))
                .resizable()
                .aspectRatio(contentMode: .fill) // This will crop the
                .frame(width: 50, height: 50)
        }

    }
    
    
}



struct SmallWeatherWidgetFirst: Widget {
    let kind: String = "SmallWeatherWidgetFirst"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                SmallWeatherWidgetFirstEntryView(entry: entry)
                    .containerBackground(.fill, for: .widget)
                
            } else {
                SmallWeatherWidgetFirstEntryView(entry: entry)
                    .padding()
                    .background()
                
            }
        }
        .configurationDisplayName("Weather Widget First")
        .description("This is Weather Widget First.")
        .contentMarginsDisabled()
        .supportedFamilies([.systemSmall])
        
    }
}


struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorImage: "ic_location", errorMessage: "Location Error")
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}




struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        
        SmallWeatherViewA(weather: Weather())
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}


#Preview(as: .systemSmall) {
    SmallWeatherWidgetFirst()
} timeline: {
    
    WeatherData(date: .now)
    
}


