//
//  AlertHelper.swift
//  Movie
//
//  Created by Tushar Arora on 12/12/24.
//

import Foundation
import UIKit

class AlertHelper {
    static func showAlert(on viewController: UIViewController,
                          title: String,
                          message: String,
                          buttonTitle: String = Strings.ok,
                          isCancelButton: Bool = false,
                          completion: (() -> Void)? = nil,
                          cancelCompletion: (() -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            completion?()
        }
        
        if isCancelButton {
            let cancelAction = UIAlertAction(title: Strings.cancel, style: .default) { _ in
                cancelCompletion?()
            }
            alertController.addAction(cancelAction)
        }
        alertController.addAction(action)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
}
