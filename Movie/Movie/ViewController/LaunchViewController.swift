//
//  LaunchViewController.swift
//  Movie
//
//  Created by Tushar Arora on 13/12/24.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        self.view.backgroundColor = .systemCyan
        self.setUpLogoView()
    }
    
    private func setUpLogoView() {
        let imageV = UIImageView(frame: CGRect(x: 50, y: 100, width: 75, height: 75))
        imageV.center = view.center
        imageV.image = UIImage(named: "movie")
        view.addSubview(imageV)
        
        UIView.animate(withDuration: 2.0, animations: {
            imageV.transform = CGAffineTransform(scaleX: 2, y: 2)
        })
    }
}
