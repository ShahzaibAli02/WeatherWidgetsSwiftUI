//
//  FontSizeNormalizer.swift
//  App
//
//  Created by Shahzaib Ali on 05/08/2024.
//

import Foundation
import UIKit
import SwiftUI
class FontSizeNormalizer {
    static let shared = FontSizeNormalizer()
    
    private let baseFont: String
    private let baseFontSize: CGFloat
    
    private init(baseFont: String = "Roboto-Medium", baseFontSize: CGFloat = 11) {
        self.baseFont = baseFont
        self.baseFontSize = baseFontSize
    }
    
    func normalizedFont(_ fontName: String, size: CGFloat) -> Font {
        var baseSize = size
    
        if Locale.current.languageCode == "ar"  {
            baseSize = size - 3
        }
         

        let baseFontDescriptor = UIFontDescriptor(name:localizedStringForKey(key:fontName) , size: baseSize)
        let baseFontCapHeight = UIFont(descriptor: baseFontDescriptor, size: baseSize).capHeight
   
        let targetFontDescriptor = UIFontDescriptor(name: fontName.toLocalizedString(), size: size)
        let targetFont = UIFont(descriptor: targetFontDescriptor, size: size)
      
        let fontSize = size * baseFontCapHeight / targetFont.capHeight
    
        return Font.custom(fontName.toLocalizedString(), size: fontSize)
    }
    
    func localizedStringForKey(key: String) -> String {
        // Get the path for the English localization
        if let path = Bundle.main.path(forResource: "en", ofType: "lproj"),
           let bundle = Bundle(path: path) {
            // Fetch the localized string from the English localization bundle
            return NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: "")
        }
        // Fallback to the key itself if the English localization is not found
        return key
    }
}
