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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
