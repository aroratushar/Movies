//
//  MovieSearchViewController.swift
//  Movie
//
//  Created by Tushar Arora on 10/12/24.
//

import UIKit

class MovieSearchViewController: UIViewController {
    private let cellIdentifier = MovieCollectionViewCell.identifier

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
        movieCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        searchBar.changeTextFieldBackgroundColor(color: .white)
        searchBar.changeTextFieldTextColor(color: .systemCyan)
    }
}

extension MovieSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = cellIdentifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? MovieCollectionViewCell
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movieDetailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController {
            navigationController?.pushViewController(movieDetailController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (movieCollectionView.frame.width - Constants.MovieCell.space) / 2
        let height = width / Constants.MovieCell.aspectRatio
        return CGSize(width: width, height: height)
    }
}
