//
//  ErrorView.swift
//  App
//
//  Created by Shahzaib Ali on 02/08/2024.
//

import Foundation
import SwiftUI


struct ErrorView : View {
    let errorImage : String
    let errorMessage : String
    var body : some View {
        VStack(alignment:.center) {
            Image(errorImage)
                .resizable()
                .aspectRatio(contentMode: .fill) // This will crop the
                .frame(width: 23, height: 23)
            Text(errorMessage)
                .font(.custom(Constants.Fonts.robotoRegular, size: 15))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
            
        }
        .containerBackground(for: .widget) {
            Color.blue // or any background color or view you want
        }
        
    }
}
