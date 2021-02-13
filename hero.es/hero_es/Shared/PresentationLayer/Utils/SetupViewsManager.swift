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
        view.backgroundColor = backgroundColor
    }
    
    static func setupLabels(with label: UILabel) {
        label.textColor = StyleGuide.Label.labelsDescription
    }
    
    static func setupNavigationController(with navigationController: UINavigationController?) {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = StyleGuide.NavigationBar.background
        appearance.titleTextAttributes = [.foregroundColor: StyleGuide.Label.labelsDescription]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.tintColor = StyleGuide.NavigationBar.tintColor
    }
    
    static func setupTableView(with tableView: UITableView?) {
        guard let tableView = tableView else { return }
        tableView.roundCorners(cornerRadius: 15, corners: .allCorners)
        tableView.backgroundColor = StyleGuide.TableView.background
        tableView.separatorStyle = .none
    }
    
    static func setupImageView(with imageView: UIImageView?) {
        let cornersToRound: UIRectCorner = [.bottomRight, .bottomLeft]
        imageView?.roundCorners(cornerRadius: 30, corners: cornersToRound)
        imageView?.layer.borderWidth = 1
        imageView?.layer.borderColor = StyleGuide.ItemCell.borderColor.cgColor
    }
}
