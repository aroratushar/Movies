//
//  MovieSearchViewController.swift
//  Movie
//
//  Created by Tushar Arora on 10/12/24.
//

import UIKit

class MovieSearchViewController: UIViewController {
    
    private let cellIdentifier = MovieCollectionViewCell.identifier
    private var viewModel = MovieSearchViewModel()
    private let activityIndicator = ActivityIndicator()

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var noDataView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setupViewModel()
    }
    
    func setUp() {
        movieCollectionView.keyboardDismissMode = .onDrag
        movieCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        searchBar.changeTextFieldBackgroundColor(color: .white)
        searchBar.changeTextFieldTextColor(color: .systemCyan)
    }
    
    private func setupViewModel() {
        viewModel.onMoviesFetched = { [weak self] in
            guard let self = self else { return }
            showNoDataView()
        }
        
        viewModel.onError = { [weak self] error in
            guard let self = self else { return }
            AlertHelper.showAlert(on: self, title: "Error", message: error.description)
            showNoDataView()
        }
        
        toggleLoader(isShow: true)
        fetchDiscoverMovieAPI(reset: true)
    }
    
    private func fetchDiscoverMovieAPI(reset: Bool = false) {
        viewModel.fetchMovies(reset: reset)
    }
    
    private func searchMovie(reset: Bool = false) {
        var query: String = ""
        if let searchText = searchBar.text, searchText.count >= 2 {
            query = searchText
        }
        viewModel.searchMovies(searchText: query, reset: reset)
    }
    
    private func showNoDataView() {
        movieCollectionView.reloadData()
        noDataView.isHidden = viewModel.movies.count > 0
        toggleLoader(isShow: false)
    }
    
    private func toggleLoader(isShow: Bool) {
        if (isShow) {
            movieCollectionView.alpha = 0
            noDataView.isHidden = true
            activityIndicator.display(in: view)
        } else {
            activityIndicator.dismiss()
            movieCollectionView.alpha = 1
        }
    }
}

extension MovieSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = cellIdentifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? MovieCollectionViewCell
        cell?.viewModel = viewModel
        cell?.delegate = self
        cell?.updateUI(movie: viewModel.movie(at: indexPath.row))
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movieDetailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController {
            movieDetailController.movieId = viewModel.movie(at: indexPath.row).id
            navigationController?.pushViewController(movieDetailController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (movieCollectionView.frame.width - Constants.MovieCell.space) / 2
        let height = width / Constants.MovieCell.aspectRatio
        return CGSize(width: width, height: height)
    }
}

extension MovieSearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                guard let self = self else { return }
                self.toggleLoader(isShow: true)
                fetchDiscoverMovieAPI(reset: true)
                searchBar.resignFirstResponder()
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text,
              !searchText.isEmpty else {
            return
        }
        if searchText.count <= 2 {
            AlertHelper.showAlert(on: self, title: Strings.AlertMessage.warning, message: Strings.AlertMessage.searchMinimumLimit)
            return
        }
        self.toggleLoader(isShow: true)
        self.searchMovie(reset: true)
    }
}

extension MovieSearchViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - frameHeight * 2 {
            if let searchText = searchBar.text, searchText.count >= 2 {
                searchMovie()
            } else {
                fetchDiscoverMovieAPI()
            }
        }
    }
}

extension MovieSearchViewController : favouriteAction {
    func showToast(message: String) {
        self.view.makeToast(message)
    }
}

