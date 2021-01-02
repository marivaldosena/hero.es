//
//  AlertUtils.swift
//  hero.es
//
//  Created by Marivaldo Sena on 23/10/20.
//

import Foundation
import UIKit

typealias ActionHandlerType = (UIAlertAction) -> Void

// MARK: - AlertUtils
struct AlertUtils {
    static func getAlertInstance(title: String?, message: String?, style: UIAlertController.Style) -> UIAlertController {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: style)
        
        return alert
    }
    
    static func addAction(_ alert: UIAlertController, title: String?, style: UIAlertAction.Style, handler: ActionHandlerType?) {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        alert.addAction(action)
    }
    
    static func showAlert(_ viewController: UIViewController, _ alert: UIAlertController) {
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func displayMessage(_ view: UIViewController, title: String?, message: String?, okButton: String?) {
        let alert = self.getAlertInstance(title: title, message: message, style: .alert)
        self.addAction(alert, title: okButton, style: .default, handler: nil)
        view.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITextFieldUtils
struct UITextFieldUtils {
    static func setFocus(on next: UITextField?, from previous: UITextField?) {
        previous?.resignFirstResponder()
        next?.becomeFirstResponder()
    }
}

// MARK: - ShareItemUtils
struct ShareItemUtils {
    static func share(_ item: CellItemProtocol, on viewController: UIViewController) {
        guard let image = item.getImage() else { return }
        guard let url = item.getUrl() else { return }
        
        let itemsToShare: [Any] = [item.name, url, image]
        let controller = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        viewController.present(controller, animated: true, completion: nil)
    }
}

// MARK: - ShareAndLikeItemProtocol
extension CellItemProtocol {
    func getImageUrl() -> URL? {
        guard let url = URL(string: self.thumbnailString) else { return nil }
        return url
    }
    
    func getImage() -> UIImage?  {
        let imageView = UIImageView()
        
        if let url = self.getImageUrl() {
            imageView.kf.setImage(with: url)
            imageView.kf.indicatorType = .activity
        } else {
            imageView.image = UIImage(named: "ComicImage")
        }
        
        return imageView.image
    }
    
    func getUrl() -> URL? {
        guard let url = URL(string: self.resourceURI) else { return nil }
        return url
    }
}
