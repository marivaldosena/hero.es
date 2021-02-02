//
//  UIColor+Appearance.swift
//  hero_es
//
//  Created by Glayce Kelly on 19/01/21.
//

import UIKit

extension UIColor {
    convenience init(hexadecimal: Int) {
        let red = CGFloat((hexadecimal >> 16) & 0xff)
        let green = CGFloat((hexadecimal >> 8) & 0xff)
        let blue = CGFloat(hexadecimal & 0xff)
        
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
    }
}

