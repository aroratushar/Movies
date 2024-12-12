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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func populate(model: MovieDetailModel?) {
        guard let movieModel = model else { return }
        titleLabel.text = movieModel.belongs_to_collection?.name
        let releaseDate = (movieModel.release_date ?? "") + " " + "(\(movieModel.original_language ?? ""))"
        let genres = movieModel.genres?.compactMap { $0.name }
        let genresString = genres?.joined(separator: ",") ?? ""
        let durationMovie =  minutesToHoursAndMinutes(movieModel.runtime ?? 0)
        let movieTime = "\(durationMovie.hours) h \(durationMovie.leftMinutes) mins"
        genreLabel.text = releaseDate + " " + genresString + " " + movieTime
    }
    
    func minutesToHoursAndMinutes(_ minutes: Int) -> (hours: Int , leftMinutes: Int) {
        return (minutes / 60, (minutes % 60))
    }
}
