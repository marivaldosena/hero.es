//
//  SetupViewsManager.swift
//  hero_es
//
//  Created by Glayce Kelly on 29/01/21.
//

import UIKit

class SetupViewsManager {
    static func setupTextFields(with textField: UITextField, placeHolder: String) {
        textField.backgroundColor = StyleGuide.Color.clear
        textField.textColor = StyleGuide.Color.gray
        textField.layer.borderWidth = 1
        textField.layer.borderColor = StyleGuide.Color.gray.cgColor
        textField.roundCorners(cornerRadius: 10, corners: .allCorners)
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder,
                                                                     attributes: [NSAttributedString.Key.foregroundColor: StyleGuide.Color.gray])
    }
    
    static func setupButtons(with button: UIButton, backgroundColor: UIColor, titleColor: UIColor) {
        button.backgroundColor = backgroundColor
        button.setTitleColor(titleColor, for: .normal)
        button.roundCorners(cornerRadius: 10, corners: .allCorners)
    }
    
    static func setupView(with view: UIView) {
        view.backgroundColor = StyleGuide.Color.lightGray
    }
    
    static func setupLabels(with label: UILabel) {
        label.textColor = StyleGuide.Color.gray
    }
}
