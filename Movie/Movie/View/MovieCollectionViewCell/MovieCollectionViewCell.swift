//
//  MovieCollectionViewCell.swift
//  Movie
//
//  Created by Tushar Arora on 10/12/24.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: MovieCollectionViewCell.self)

    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    func setUp() {
        moviePosterImageView.layer.cornerRadius = 8.0
        moviePosterImageView.clipsToBounds = true
    }
}
