//
//  MovieTitleDetailCell.swift
//  Movie
//
//  Created by Tushar Arora on 11/12/24.
//

import UIKit

class MovieTitleDetailCell: UITableViewCell {
    static let identifier = String(describing: MovieTitleDetailCell.self)

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
