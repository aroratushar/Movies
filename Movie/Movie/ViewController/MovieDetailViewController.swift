//
//  MovieDetailViewController.swift
//  Movie
//
//  Created by Tushar Arora on 11/12/24.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    public var movieId: Int?
    private var viewModel = MovieDetailViewModel()
    private let activityIndicator = ActivityIndicator()
    let dispatchGroup = DispatchGroup()
    
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
        setupViewModel()
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
    
    func fetchMovieDetails() {
        guard let mId = movieId else {
            return
        }

        dispatchGroup.enter()
        viewModel.fetchMovieDetail(movieId: mId)
        dispatchGroup.enter()
        viewModel.fetchMovieCastDetail(movieId: mId)
        
        dispatchGroup.notify(queue: .main) {  [weak self] in
            guard let self = self else { return }
            self.showNoDataView()
        }
    }
    
    private func setupViewModel() {
        viewModel.onMovieDetailFetched = { [weak self] in
            guard let self = self else { return }
            dispatchGroup.leave()
        }
        
        viewModel.onMovieCastDetailFetched = { [weak self] in
            guard let self = self else { return }
            dispatchGroup.leave()
        }
        
        viewModel.onError = { [weak self] error in
            guard let self = self else { return }
            dispatchGroup.leave()
            AlertHelper.showAlert(on: self, title: "Error", message: error.description)
            showNoDataView()
        }
        
        toggleLoader(isShow: true)
        fetchMovieDetails()
    }
    
    private func showNoDataView() {
        let placeHolderImage = UIImage(named: "fallBack")
        let imagePath = API.imageBaseUrl + (viewModel.movieDetailModel?.poster_path ?? "")
        movieHeaderImage.setImage(uri: imagePath, placeholder: placeHolderImage, completion: nil)
        movieDetailTableView.reloadData()
        self.toggleLoader(isShow: false)
    }
    
    private func toggleLoader(isShow: Bool) {
        if (isShow) {
            movieDetailTableView.alpha = 0
            activityIndicator.display(in: view)
        } else {
            activityIndicator.dismiss()
            movieDetailTableView.alpha = 1
        }
    }
}

extension MovieDetailViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 3
     }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         if indexPath.row == 0 {
             let cell = tableView.dequeueReusableCell(withIdentifier: MovieTitleDetailCell.identifier, for: indexPath) as! MovieTitleDetailCell
             cell.populate(model: viewModel.movieDetailModel)
             return cell
         } else if indexPath.row == 1 {
             let cell = tableView.dequeueReusableCell(withIdentifier: MovieDescriptionTableViewCell.identifier, for: indexPath) as! MovieDescriptionTableViewCell
             cell.populate(model: viewModel.movieDetailModel)
             return cell
         } else {
             let cell = tableView.dequeueReusableCell(withIdentifier: MovieCastTableViewCell.identifier, for: indexPath) as! MovieCastTableViewCell
             cell.populate(cast: viewModel.movieCastModel)
             return cell
         }
     }
}
