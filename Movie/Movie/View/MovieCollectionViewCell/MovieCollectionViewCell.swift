//
//  MovieCollectionViewCell.swift
//  Movie
//
//  Created by Tushar Arora on 10/12/24.
//

import UIKit

protocol favouriteAction: UIViewController {
    func showToast(message: String)
}

class MovieCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: favouriteAction?
    private var movieData: MovieResults?
    static let identifier = String(describing: MovieCollectionViewCell.self)
    private let placeHolderImage = UIImage(named: "fallBack")
    public var viewModel: MovieSearchViewModel?

    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    func setUp() {
        moviePosterImageView.layer.cornerRadius = 8.0
        moviePosterImageView.clipsToBounds = true
    }
    
    func updateUI(movie: MovieResults) {
        movieData = movie
        movieTitleLabel.text = movie.title
        releaseDateLabel.text = movie.release_date
        let imagePath = API.imageBaseUrl + (movie.poster_path ?? "")
        moviePosterImageView.setImage(uri: imagePath, placeholder: placeHolderImage, completion: nil)
        favouriteButton.tintColor = CoreDataManager.shared.isMovieInFavorites(movie) ? .red : .white
    }
    
    func populateCast(model: Cast) {
        favouriteButton.isHidden = true
        movieTitleLabel.text = model.original_name
        releaseDateLabel.text = model.character
        let imagePath = API.imageBaseUrl + (model.profile_path ?? "")
        moviePosterImageView.setImage(uri: imagePath, placeholder: placeHolderImage, completion: nil)
    }
    
    @IBAction func favouriteAction(_ sender: Any) {
        guard let movieInfo = movieData,let movieViewModel = viewModel else { return }
        let isFav = movieViewModel.isMovieInFavorites(movieInfo)
        if isFav == false {
            movieViewModel.saveMovieToFavorites(movieInfo)
            delegate?.showToast(message: Strings.AlertMessage.addedInFavourite)
            favouriteButton.tintColor = .red
        } else {
            movieViewModel.removeMovieFromFavorites(movieInfo)
            delegate?.showToast(message: Strings.AlertMessage.removedFromFavourite)
            favouriteButton.tintColor = .white
        }
    }
    
}
