//
//  ActivityIndicator.swift
//  Movie
//
//  Created by Tushar Arora on 12/12/24.
//

import Foundation
import UIKit

class ActivityIndicator: UIActivityIndicatorView {
    
    override init(style: UIActivityIndicatorView.Style = UIActivityIndicatorView.Style.large) {
        super.init(style: style)
        color = .white
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func display(in view: UIView) {
        backgroundColor = UIColor.clear
        view.addSubview(self)
        view.center(subview: self)
        startAnimating()
    }
    
    func dismiss() {
        removeFromSuperview()
        stopAnimating()
    }
    
}
