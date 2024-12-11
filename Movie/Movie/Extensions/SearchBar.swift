//
//  SearchBar.swift
//  Movie
//
//  Created by Tushar Arora on 11/12/24.
//

import Foundation
import UIKit

extension UISearchBar {
    
    func changeTextFieldBackgroundColor(color: UIColor) {
        if let textfield = self.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = color
        }
    }
    
    func changeTextFieldTextColor(color: UIColor) {
        if let textfield = self.value(forKey: "searchField") as? UITextField {
            textfield.textColor = color
        }
    }
}
