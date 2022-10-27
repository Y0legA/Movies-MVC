// HomeViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
///
final class HomeViewController: UIViewController {
    private enum Constants {
        enum MovieTypes: String {
            case popular = "Popular"
            case topRated = "Top Rated"
            case upComing = "Up Coming"
        }

        static let backGroundView = "backGround"
        static let backGroundColor = "backgroundColor"
        static let title = "Movies"
        static let movieIdentifier = "movie"
        static let topTypeMovieSC = 0.0
        static let heightButton = 30.0
    }

    // MARK: - Private Visual Components

    private var popularButton = UIButton()
    private var topRatedButton = UIButton()
    private var upComingButton = UIButton()
    private let tableView = UITableView()

    // MARK: - Public Properties

    // MARK: - Private Properties

    private let networkManager = NetworkManager()
    private let movieTypes = [
        Constants.MovieTypes.popular.rawValue,
        Constants.MovieTypes.topRated.rawValue,
        Constants.MovieTypes.upComing.rawValue
    ]
    private var movies: [Movie] = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Public Methods

    // MARK: - Private IBAction

    @objc private func showPopularyAction() {
        networkManager.fetchPopularyResult { movies in
            DispatchQueue.main.async {
                guard let result = try? movies.get().results else { return }
                self.movies = result
                self.title = Constants.MovieTypes.popular.rawValue
                self.tableView.reloadData()
                self.scrollToTop()
            }
        }
    }

    @objc private func showTopRatedAction() {
        networkManager.fetchTopRatedResult { movies in
            DispatchQueue.main.async {
                guard let result = try? movies.get().results else { return }
                self.movies = result
                self.title = Constants.MovieTypes.topRated.rawValue
                self.tableView.reloadData()
                self.scrollToTop()
            }
        }
    }

    @objc private func showUpComingAction() {
        networkManager.fetchUpComingResult { movies in
            DispatchQueue.main.async {
                guard let result = try? movies.get().results else { return }
                self.movies = result
                self.title = Constants.MovieTypes.upComing.rawValue
                self.tableView.reloadData()
                self.scrollToTop()
            }
        }
    }

    @objc private func uploadDataAction() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.tableView.refreshControl?.endRefreshing()
//            self.tableView.reloadData()
//        }
    }

    // MARK: - Private Methods

    private func scrollToTop() {
        let topRow = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: topRow, at: .top, animated: true)
    }

//    private func upload() {
//        refreshControl.addTarget(self, action: #selector(uploadDataAction), for: .valueChanged)
//        tableView.refreshControl = refreshControl
//    }

    private func fetchData() {
        networkManager.fetchPopularyResult { movie in
            DispatchQueue.main.async {
                guard let result = try? movie.get().results else { return }
                self.movies = result
                self.tableView.reloadData()
            }
        }
    }

    private func configureUI() {
        configureNavBar()
        configureView()
        configurePopularButton()
        configureTopRatedButton()
        configureUpComingButton()
        configureTableview()
        fetchData()
        uploadDataAction()
    }

    private func configureView() {
        view.backgroundColor = UIColor(named: Constants.backGroundColor)
    }

    private func configureNavBar() {
        title = Constants.title
    }

    private func configurePopularButton() {
        popularButton.addTarget(self, action: #selector(showPopularyAction), for: .touchUpInside)
        view.addSubview(popularButton)
        popularButton.setTitle(Constants.MovieTypes.popular.rawValue, for: .normal)
        popularButton.backgroundColor = .systemTeal
        popularButton.layer.cornerRadius = 7
        popularButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popularButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            popularButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            popularButton.widthAnchor.constraint(equalToConstant: 100),
            popularButton.heightAnchor.constraint(equalToConstant: Constants.heightButton)
        ])
    }

    private func configureTopRatedButton() {
        topRatedButton.addTarget(self, action: #selector(showTopRatedAction), for: .touchUpInside)
        view.addSubview(topRatedButton)
        topRatedButton.setTitle(Constants.MovieTypes.topRated.rawValue, for: .normal)
        topRatedButton.backgroundColor = .systemTeal
        topRatedButton.layer.cornerRadius = 7
        topRatedButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topRatedButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topRatedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topRatedButton.widthAnchor.constraint(equalToConstant: 100),
            topRatedButton.heightAnchor.constraint(equalToConstant: Constants.heightButton)
        ])
    }

    private func configureUpComingButton() {
        upComingButton.addTarget(self, action: #selector(showUpComingAction), for: .touchUpInside)
        view.addSubview(upComingButton)
        upComingButton.setTitle(Constants.MovieTypes.upComing.rawValue, for: .normal)
        upComingButton.backgroundColor = .systemTeal
        upComingButton.layer.cornerRadius = 7
        upComingButton.backgroundColor = .systemTeal
        upComingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            upComingButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            upComingButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            upComingButton.widthAnchor.constraint(equalToConstant: 100),
            upComingButton.heightAnchor.constraint(equalToConstant: Constants.heightButton)
        ])
    }

    private func configureTableview() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundView = UIImageView(image: UIImage(named: Constants.backGroundView))
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: Constants.movieIdentifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topRatedButton.bottomAnchor, constant: 10),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        ])
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.movieIdentifier, for: indexPath)
            as? MovieTableViewCell else { return UITableViewCell() }
        let movie = movies[indexPath.row]
        cell.backgroundColor = .clear
        cell.setDescription(model: movie)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailMovie = movies[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.imageName = detailMovie.poster
        networkManager.fetchCreditsResult(detailMovie.id) { movie in
            DispatchQueue.main.async {
                detailVC.title = detailMovie.title
                guard let movieDetail = try? movie.get().cast else { return }
                detailVC.movieDescription = detailMovie.overview
                detailVC.actorNames = movieDetail.map { $0.name ?? "" }
                detailVC.actorImageNames = movieDetail.map { $0.profilePath ?? "" }
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.bounds.height / 4
    }
}

extension HomeViewController: UITableViewDelegate {}
