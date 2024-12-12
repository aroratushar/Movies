//
//  MovieDescriptionTableViewCell.swift
//  Movie
//
//  Created by Tushar Arora on 11/12/24.
//

import UIKit

class MovieDescriptionTableViewCell: UITableViewCell {
    static let identifier = String(describing: MovieDescriptionTableViewCell.self)

    @IBOutlet weak var tagLineLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populate(model: MovieDetailModel?) {
        guard let movieModel = model else { return }
        tagLineLabel.text = movieModel.tagline
        movieDescriptionLabel.text = movieModel.overview
    }
    
}
