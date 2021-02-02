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
        textField.textColor = StyleGuide.TextField.textColor
        textField.layer.borderWidth = 1
        textField.layer.borderColor = StyleGuide.TextField.borderColor.cgColor
        textField.roundCorners(cornerRadius: 10, corners: .allCorners)
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder,
                                                             attributes: [NSAttributedString.Key.foregroundColor: StyleGuide.TextField.placeHolderColor])
    }
    
    static func setupButtons(with button: UIButton, backgroundColor: UIColor, titleColor: UIColor) {
        button.backgroundColor = backgroundColor
        button.setTitleColor(titleColor, for: .normal)
        button.roundCorners(cornerRadius: 10, corners: .allCorners)
    }
    
    static func setupView(with view: UIView, backgroundColor: UIColor = StyleGuide.View.background) {
//        view.backgroundColor = StyleGuide.Color.lightGray
        view.backgroundColor = backgroundColor
    }
    
    static func setupLabels(with label: UILabel) {
        label.textColor = StyleGuide.Label.labelsDescription
    }
    
    static func setupNavigationControllet() {
        
    }
}
