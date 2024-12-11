//
//  MovieDetailViewController.swift
//  Movie
//
//  Created by Tushar Arora on 11/12/24.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var movieDetailTableView: UITableView!
    @IBOutlet weak var movieHeaderImage: UIImageView!
    let identifiers = [
        MovieTitleDetailCell.identifier,
        MovieDescriptionTableViewCell.identifier,
        MovieCastTableViewCell.identifier
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    func setUp() {
        movieDetailTableView.rowHeight = UITableView.automaticDimension
        movieDetailTableView.estimatedRowHeight = 120
        identifiers.forEach { movieDetailTableView.register(UINib(nibName: $0, bundle: nil), forCellReuseIdentifier: $0) }
    }
}

extension MovieDetailViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 3
     }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         if indexPath.row == 0 {
             let cell = tableView.dequeueReusableCell(withIdentifier: MovieTitleDetailCell.identifier, for: indexPath) as! MovieTitleDetailCell
             return cell
         } else if indexPath.row == 1 {
             let cell = tableView.dequeueReusableCell(withIdentifier: MovieDescriptionTableViewCell.identifier, for: indexPath) as! MovieDescriptionTableViewCell
             return cell
         } else {
             let cell = tableView.dequeueReusableCell(withIdentifier: MovieCastTableViewCell.identifier, for: indexPath) as! MovieCastTableViewCell
             return cell
         }
     }
}
