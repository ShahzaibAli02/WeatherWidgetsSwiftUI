//
//  ForeCastHourlyView.swift
//  App
//
//  Created by Shahzaib Ali on 03/08/2024.
//

import Foundation
import SwiftUI

struct ForeCastHourlyView: View {
    let time:String
    let icon:String
    let temp:String?
    var textColor:Color
    
    init(weather:Weather,index:Int, textColor: Color = .white) {
        
        if textColor != .white{
            self.time = NSLocalizedString("now", comment:"")
        }
        else{
            self.time = DateTime.shared.convertToAmPm(dateString: weather._6hoursForeCastTemp?[index].date)
        }
       
        self.icon = Utils.getWhiteWeatherIcon(dateValue: weather._6hoursForeCastIcons?[index])
        self.temp = weather._6hoursForeCastTemp?[index].value.roundedStringValue()
        self.textColor = textColor
    }
    var body: some View {
        VStack(alignment:.center){
            
            Text(time)
                .font(.custom(Constants.Fonts.robotoRegular, size: 12))
                .foregroundStyle(textColor)
                .multilineTextAlignment(.leading)
            Spacer().frame(height:10)
            Image(icon)
                .resizable()
                .scaledToFill()
                .frame(width: 20,height: 20)
            Spacer().frame(height:10)
            Text("\(temp.value())°")
                .font(.custom(Constants.Fonts.robotoMedium, size: 12))
                .foregroundStyle(.white)
                .multilineTextAlignment(.leading)
        }
    }
}
