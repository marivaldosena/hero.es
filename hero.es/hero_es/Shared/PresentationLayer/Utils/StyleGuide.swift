//
//  StyleGuide.swift
//  hero_es
//
//  Created by Glayce Kelly on 19/01/21.
//

import Foundation
import UIKit

struct StyleGuide {
    
    //*************************************************
    // MARK: - Init
    //*************************************************
    
    private init() { }
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    static private var isDarkMode: Bool {
        let defaults: UserDefaults = UserDefaults.standard
        let value: Bool = defaults.bool(forKey: "darkModeKey")
        return value
    }
    
}

//*************************************************
// MARK: - Colors
//*************************************************

extension StyleGuide {
    
    struct Color {
        static var white: UIColor = UIColor.white
        static var black: UIColor = UIColor.black
        static var clear: UIColor = UIColor.clear
        static var blue: UIColor = UIColor(hexadecimal: 0x1D7DEF)
        static var darkBlue: UIColor = UIColor(hexadecimal: 0x222831)
        static var gray: UIColor = UIColor(hexadecimal: 0x393E46)
        static var darkGray: UIColor = UIColor(hexadecimal: 0x323232)
        static var secondaryBlack: UIColor = UIColor(hexadecimal: 0x352E44)
        static var secondaryWhite: UIColor = UIColor(hexadecimal: 0xEEEEEE)
        static var tertiaryWhite: UIColor = UIColor(hexadecimal: 0xFFE7D0)
    }
    
}

//*************************************************
// MARK: - Color Presets
//*************************************************

extension StyleGuide {
    
    struct Button {
        static var loginButton: UIColor { isDarkMode ? StyleGuide.Color.darkBlue : StyleGuide.Color.secondaryWhite }
    }
    
    struct View {
        static var background: UIColor { isDarkMode ? StyleGuide.Color.darkBlue : StyleGuide.Color.secondaryWhite }
    }
    
}
