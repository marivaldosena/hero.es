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
    // MARK: - Private Properties
    //*************************************************
    
    static private var isDarkMode: Bool {
//        let defaults: UserDefaults = UserDefaults.standard
//        let value: Bool = defaults.bool(forKey: "darkModeKey")
//        return value
        let value = ConfigViewController.darkModeTeste ?? false
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
        static var lightBlue: UIColor = UIColor(hexadecimal: 0x00ADB5)
        static var gray: UIColor = UIColor(hexadecimal: 0x393E46)
        static var lightGray: UIColor = UIColor(hexadecimal: 0xeeeeee)
        static var lightSecondaryGray: UIColor = UIColor(hexadecimal: 0xD8D8D8)
        static var darkGray: UIColor = UIColor(hexadecimal: 0x323232)
        static var secondaryBlack: UIColor = UIColor(hexadecimal: 0x1B1B1B)
        static var secondaryWhite: UIColor = UIColor(hexadecimal: 0xEEEEEE)
        static var tertiaryWhite: UIColor = UIColor(hexadecimal: 0xFFE7D0)
    }
    
}

//*************************************************
// MARK: - Color Presets
//*************************************************

extension StyleGuide {
    
    struct Button {
        static var loginButton: UIColor { StyleGuide.Color.darkBlue }
        static var createAccountButton: UIColor { StyleGuide.Color.lightSecondaryGray }
        static var changeDataButton: UIColor { isDarkMode ? StyleGuide.Color.blue : StyleGuide.Color.darkBlue }
        static var deleteUserButton: UIColor { isDarkMode ? StyleGuide.Color.darkBlue : StyleGuide.Color.lightSecondaryGray }
        static var changeLanguageButton: UIColor { isDarkMode ? StyleGuide.Color.lightSecondaryGray : StyleGuide.Color.gray }
        
        struct ButtonTextColor {
            static var loginTextButton: UIColor { isDarkMode ? StyleGuide.Color.white : StyleGuide.Color.secondaryWhite }
            static var createAccountTextButton: UIColor { isDarkMode ? StyleGuide.Color.darkGray : StyleGuide.Color.secondaryWhite }
            static var changeDataTextButton: UIColor { StyleGuide.Color.white }
            static var deleteUserTextButton: UIColor { isDarkMode ? StyleGuide.Color.white : StyleGuide.Color.darkGray }
            static var changeLanguageTextButton: UIColor { isDarkMode ? StyleGuide.Color.darkGray : StyleGuide.Color.white }
        }
    }
    
    struct View {
        static var background: UIColor { isDarkMode ? StyleGuide.Color.darkGray : StyleGuide.Color.secondaryWhite }
        static var containerCellViewBackground: UIColor { isDarkMode ? StyleGuide.Color.white : StyleGuide.Color.secondaryWhite }
    }
    
    struct Label {
        static var placeHolderButtons: UIColor { isDarkMode ? StyleGuide.Color.white : StyleGuide.Color.darkGray }
        static var labelsDescription: UIColor { isDarkMode ? StyleGuide.Color.white : StyleGuide.Color.darkGray }
    }
    
    struct TextField {
        static var borderColor: UIColor { isDarkMode ? StyleGuide.Color.white : StyleGuide.Color.gray }
        static var textColor: UIColor { isDarkMode ? StyleGuide.Color.white : StyleGuide.Color.gray }
        static var placeHolderColor: UIColor { isDarkMode ? StyleGuide.Color.white : StyleGuide.Color.gray }
    }
    
    struct NavigationController {
        static var background: UIColor { isDarkMode ? StyleGuide.Color.darkGray : StyleGuide.Color.secondaryWhite }
    }
    
}
