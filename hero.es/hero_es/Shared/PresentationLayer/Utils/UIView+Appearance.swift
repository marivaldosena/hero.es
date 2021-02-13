//
//  UIView+Appearance.swift
//  hero_es
//
//  Created by Glayce Kelly on 21/01/21.
//

import UIKit

extension UIView {
    func roundCorners(cornerRadius: CGFloat, corners: UIRectCorner) {
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = cornerMask(from: corners)
        layer.masksToBounds = true
    }
    
    private func cornerMask(from rectCorner: UIRectCorner) -> CACornerMask {
        var cornerMask: CACornerMask = []
        
        if rectCorner.contains(.topLeft) {
            cornerMask.insert(.layerMinXMinYCorner)
        }
        
        if rectCorner.contains(.topRight) {
            cornerMask.insert(.layerMaxXMinYCorner)
        }
        
        if rectCorner.contains(.bottomLeft) {
            cornerMask.insert(.layerMinXMaxYCorner)
        }
        
        if rectCorner.contains(.bottomRight) {
            cornerMask.insert(.layerMaxXMaxYCorner)
        }
        
        return cornerMask
    }
}
