//
//  SmallWeatherViewA.swift
//  App
//
//  Created by Shahzaib Ali on 02/08/2024.
//

import Foundation
import SwiftUI
struct LargeWeatherView : View {
    let weather:Weather
    let weatherSymbol :WeatherSymbol
    init(weather: Weather) {
        self.weather = weather
        self.weatherSymbol = Constants.weatherData[weather.weatherSymbol ?? 0] ??  Constants.weatherData.first!.value
    }
    var body: some View {
        VStack(alignment:.leading,spacing:0){
            MediumWeatherView(weather: weather)
            Spacer().frame(height: 10)
            HStack{
                Image("ic_chart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15,height: 15)
                Text(NSLocalizedString("five_days_forecast", comment:""))
                    .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoBold, size: 13))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            Spacer().frame(height: 10)
            VStack(alignment:.leading,spacing:7){
                
                
                FiveDayForeCastView(weather: weather, index: 0)
                FiveDayForeCastView(weather: weather, index: 1)
                FiveDayForeCastView(weather: weather, index: 2)
                FiveDayForeCastView(weather: weather, index: 3)
                FiveDayForeCastView(weather: weather, index: 4)
                
                
                
            }
            
        }

        .containerBackground(for: .widget) {
            Color.blue // or any background color or view you want
        }
    }
}


func getWeatherDescription(val:Int?) ->String{
    
    return Constants.weatherData[val ?? 0]?.description ?? ""
}
func getWeatherDescription(val:Double?) ->String{
    
    guard let mVal = val else{
        return ""
    }
    return getWeatherDescription(val: Int(mVal))
}

struct LargeWeatherView_Previews: PreviewProvider {
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
        
        LargeWeatherView(weather:mWeather)
        
    }
}




struct FiveDayForeCastView: View {
    let day:String
    let date:String
    let image:String
    let weather:String
    let highTemp:String
    let lowTemp:String
    init(weather:Weather,index:Int) {
        self.day = DateTime.shared.toDayName(dateString: weather._5DaysForeCastIcons?[index].date)
        self.date =  DateTime.shared.toShortDate(dateString: weather._5DaysForeCastIcons?[index].date)
        self.image = Utils.getWhiteWeatherIcon(dateValue: weather._5DaysForeCastIcons?[index])
        
        
        self.weather = getWeatherDescription(val:weather._5DaysForeCastIcons?[index].value)
        
        
        
        self.highTemp = weather._5DaysForeCastHighTemp?[index].value.roundedStringValue() ?? ""
        self.lowTemp = weather._5DaysForeCastLowTemp?[index].value.roundedStringValue() ?? ""
        
        
    }
    
    var body: some View {
        HStack{
            
            VStack(alignment:.leading){
                
                Text(day)
                    .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoMedium, size: 12))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                Text(date)
                    .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoMedium, size: 10))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                
                
            }
            Spacer()
            
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 25,height: 25)
            
            Spacer()
            Text(weather)
                .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoMedium, size: 13))
                .foregroundStyle(.white)
                .lineLimit(1)
                .truncationMode(.tail)
            Spacer()
            Text("\(highTemp)°")
                .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoMedium, size: 13))
                .foregroundStyle(.white)
                .lineLimit(1)
                .truncationMode(.tail)
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            
            Spacer()
            Text("\(lowTemp)°")
                .font(FontSizeNormalizer.shared.normalizedFont(Constants.Fonts.robotoMedium, size: 13))
                .foregroundStyle(.white)
                .lineLimit(1)
                .truncationMode(.tail)
            
        }
    }
}
