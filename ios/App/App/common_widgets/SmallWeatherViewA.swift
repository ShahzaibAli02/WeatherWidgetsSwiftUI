//
//  SmallWeatherViewA.swift
//  App
//
//  Created by Shahzaib Ali on 02/08/2024.
//

import Foundation
import SwiftUI
struct SmallWeatherViewA : View {
    let weather:Weather
    let weatherSymbol :WeatherSymbol
    init(weather: Weather) {
        self.weather = weather
        self.weatherSymbol = Constants.weatherData[weather.weatherSymbol ?? 0] ??  Constants.weatherData.first!.value
    }
    var body: some View {
        VStack(alignment:.leading,spacing:0){
            
            Spacer().frame(height: 5)
//            Text(NSLocalizedString("welcome_message", comment: ""))
//                .font(.custom(Constants.Fonts.robotoMedium, size: 11))
//                .foregroundStyle(.white)
//                .lineLimit(1)
//                .truncationMode(.tail) 
            
            
            Text(weather.cityName)
                .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoMedium, size:11))
                .foregroundStyle(.white)
                .lineLimit(1)
                .truncationMode(.tail)
            
            HStack(){
                
                Text("\(weather.currentTemperature.roundedStringValue())°\("c".toLocalizedString())")
                    .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoMedium, size: 35))
                    .foregroundStyle(.white)
                    .truncationMode(.tail)
                    .lineLimit(1)
                
                
                VStack(alignment:.leading){
                    Text("feels".toLocalizedString())
                        .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoMedium, size: 10))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.leading)
                    Text("\("like".toLocalizedString()) \(weather.currentFeelLikeTemp.roundedStringValue())°")
                        .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoMedium, size: 10))
                        .foregroundStyle(.white)
                        .lineLimit(2)
                        .truncationMode(.tail)
                        .multilineTextAlignment(.leading)
                    
                    
                }
              
                
            }
            
            Spacer().frame(height: 4)
            Image(weatherSymbol.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 40,height: 40)

            
            Spacer().frame(height: 4)
            
            Text(weatherSymbol.description)
                .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoBold, size: 14))
                .foregroundStyle(.white)
                .lineLimit(1)
                .truncationMode(.tail)
            
            Spacer().frame(height: 3)
            HStack(spacing:2){
                
                Text("high".toLocalizedString())
                    .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoRegular, size: 10))
                    .foregroundStyle(.white)
                
                
                Text("\(weather.currentFeelLikeTemp.roundedStringValue())°")
                    .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoMedium, size: 11))
                    .foregroundStyle(.white)
                
                Spacer().frame(width:5)
                
                Text("low".toLocalizedString())
                    .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoRegular, size: 10))
                    .foregroundStyle(.white)
                
                
                Text("\(weather.currentFeelLikeTemp.roundedStringValue())°")
                    .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoMedium, size: 11))
                    .foregroundStyle(.white)
                
                
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .topLeading)
        .padding(15)
        .containerBackground(for: .widget) {
            Color.blue // or any background color or view you want
        }
    }
}
