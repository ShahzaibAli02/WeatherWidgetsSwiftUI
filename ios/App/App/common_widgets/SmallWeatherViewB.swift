//
//  SmallWeatherViewA.swift
//  App
//
//  Created by Shahzaib Ali on 02/08/2024.
//

import Foundation
import SwiftUI
struct SmallWeatherViewB : View {
    let weather:Weather
    let weatherSymbol :WeatherSymbol
    init(weather: Weather) {
        self.weather = weather
        self.weatherSymbol = Constants.weatherData[weather.weatherSymbol ?? 0] ??  Constants.weatherData.first!.value
    }
    var body: some View {
        VStack(alignment:.leading,spacing:0){
            
            HStack(){
                
                VStack(alignment:.leading){
                    Spacer().frame(height: 10)
                    Text(weather.cityName)
                        .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoMedium, size: 11))
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
        
                    Text("\(weather.currentTemperature.roundedStringValue())°\("c".toLocalizedString())")
                        .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoMedium, size: 35))
                        .foregroundStyle(.white)
                        .truncationMode(.tail)
                        .lineLimit(1)
                    
                    
                }
                
                VStack(alignment:.center){
                    
                    Image(weatherSymbol.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30,height: 30)
                
                    Spacer().frame(height: 4)
                    HStack(spacing:0){
                        Text("h".toLocalizedString())
                            .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoRegular, size: 10))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                        
                        Text("\(weather._24hHighTemp.roundedStringValue())°")
                            .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoBold, size: 10))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                    }
                    
                    HStack(spacing:0){
                        Text("l".toLocalizedString())
                            .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoRegular, size: 10))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                        
                        Text("\(weather._24LowTemp.roundedStringValue())°")
                            .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoBold, size: 10))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                    }
                  
             
                    
                    
                }
                
                
            }
            
            Spacer().frame(height: 10)
            
            HStack{
            
                Text(NSLocalizedString("precip", comment: ""))
                    .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoMedium, size: 15))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Spacer()
                
                Text("\(weather._24Precip.value())\("mm".toLocalizedString())")
                    .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoRegular, size: 15))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .opacity(0.7)
                
                
            }
            Spacer().frame(height: 4)
            HStack{
            
                Text(NSLocalizedString("chance", comment: ""))
                    .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoMedium, size: 15))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Spacer()
                
                Text("\(weather._24PrecipProb.value().roundedStringValue())%")
                    .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoRegular, size: 15))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .opacity(0.7)
                
                
            }
            Spacer().frame(height: 4)
            HStack{
            
                Text(NSLocalizedString("wind", comment: ""))
                    .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoMedium, size: 15))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Spacer()
                
                Text("\(weather._24WindSpeed.value().roundedStringValue()) \("kmh".toLocalizedString()) \(Utils.direction(from:weather._24WindDirection))")
                    .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoRegular, size: 15))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .opacity(0.7)
                
                
            }
        
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .topLeading)
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
    
        .containerBackground(for: .widget) {
            Color.blue // or any background color or view you want
        }
    }
}

struct SmallWeatherViewB_Previews: PreviewProvider {
    static var mWeather: Weather = {
        var weather = Weather()
        weather.currentTemperature = "32"
        weather.cityName = "Islamabad"
        weather._24hHighTemp = "25"
        weather._24LowTemp = "23"
        weather._24Precip = "0.02"
        weather._24PrecipProb = "70"
        weather._24WindSpeed = "12"
        weather._24WindDirection = "45"
        weather.weatherSymbol=1
        return weather
    }()
    
    static var previews: some View {
        
        SmallWeatherViewB(weather:mWeather)
        
    }
}

