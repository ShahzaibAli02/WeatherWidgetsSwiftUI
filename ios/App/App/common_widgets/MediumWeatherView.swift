//
//  SmallWeatherViewA.swift
//  App
//
//  Created by Shahzaib Ali on 02/08/2024.
//

import Foundation
import SwiftUI
struct MediumWeatherView : View {
    let weather:Weather
    let weatherSymbol :WeatherSymbol
    var startIndex : Int = 0
    init(weather: Weather) {
        self.weather = weather
        self.weatherSymbol = Constants.weatherData[weather.weatherSymbol ?? 0] ??  Constants.weatherData.first!.value
        self.startIndex = Utils.getCurrentIndex(_6hoursForeCastTemp: weather._6hoursForeCastTemp)
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
                Spacer()
                
                VStack(alignment:.trailing){
                    
                    Image(weatherSymbol.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40,height: 40)
                    
                    Spacer().frame(height: 4)
                    
                    //ALIGN THIS TEXT TO END
                    Text(weatherSymbol.description)
                        .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoBold, size: 12))
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    
                    
                    HStack(spacing:0){
                        Text(NSLocalizedString("high", comment:""))
                            .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoRegular, size: 10))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                        
                        Text("\(weather._24hHighTemp.roundedStringValue())°")
                            .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoBold, size: 10))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                        Spacer().frame(width: 5)
                        Text(NSLocalizedString("low", comment:""))
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
                
               
                ForeCastHourlyView(weather: weather, index:startIndex+0,textColor:Color(hex:"#FFAF00"))
                Spacer()
                ForeCastHourlyView(weather: weather, index:startIndex+1)
        
                Spacer()
                ForeCastHourlyView(weather: weather, index:startIndex+2)
                Spacer()
                ForeCastHourlyView(weather: weather, index:startIndex+3)
                Spacer()
                ForeCastHourlyView(weather: weather, index:startIndex+4)
                Spacer()
                ForeCastHourlyView(weather: weather, index:startIndex+5)
                
                
            }.padding(EdgeInsets(top:0, leading:10,bottom: 0,trailing: 10))
            
            
            
        }
        
        .containerBackground(for: .widget) {
            Color.blue // or any background color or view you want
        }
    }
}

struct MediumWeatherViewViewB_Previews: PreviewProvider {
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
        
        MediumWeatherView(weather:mWeather)
        
    }
}



