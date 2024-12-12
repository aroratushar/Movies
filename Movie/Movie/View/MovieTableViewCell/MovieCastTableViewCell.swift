//
//  MovieCastTableViewCell.swift
//  Movie
//
//  Created by Tushar Arora on 11/12/24.
//

import UIKit

class MovieCastTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: MovieCastTableViewCell.self)
    private var castInfoArray: [Cast] = []
    private let cellIdentifier = MovieCollectionViewCell.identifier
    
    @IBOutlet weak var castCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    func setUp() {
        castCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        castCollectionView.dataSource = self
        castCollectionView.delegate = self
    }
    
    func populate(cast: MovieCastModel?) {
        guard let movieCast = cast, let castInfo = movieCast.cast  else { return }
        castInfoArray = castInfo
        castCollectionView.reloadData()
    }
}

extension MovieCastTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        castInfoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = cellIdentifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? MovieCollectionViewCell
        cell?.populateCast(model: castInfoArray[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (castCollectionView.frame.width - Constants.MovieCell.space) / 2
        let height = width / Constants.MovieCell.aspectRatio
        return CGSize(width: width, height: height)
    }
}
