//
//  UIView.swift
//  Movie
//
//  Created by Tushar Arora on 12/12/24.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(with radius: CGFloat = 8) {
        let center = self.center
        layer.cornerRadius = radius
        self.center = center
        clipsToBounds = true
    }
    
    func center(subview: UIView) {
        guard subviews.contains(subview) else { return }
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        subview.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
