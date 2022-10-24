// HomeViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
///
class HomeViewController: UIViewController {
    private enum Constants {
        enum MovieTypes: String {
            case popular = "Popular"
            case topRated = "Top RatedTop"
            case upComing = "Up Coming"
        }

        static let title = "Movies"
        static let movieIdentifier = "movie"
        // static let heightRow = 30.0
        static let topTypeMovieSC = 0.0
        static let heightTypeMovieSC = 30.0
    }

    // MARK: - Private Visual Components

    private var chooseTypeMovieSegmentedControl = UISegmentedControl()
    private let tableView = UITableView()

    // MARK: - Public Properties

    // MARK: - Private Properties

    private let movieTypes = [
        Constants.MovieTypes.popular.rawValue,
        Constants.MovieTypes.topRated.rawValue,
        Constants.MovieTypes.upComing.rawValue
    ]
    private let movies: [MovieInfo] = testMovies // временные данные!!!
//    private let movies: [MovieInfo] = []

    // MARK: - Initializers

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Public Methods

    // MARK: - Private IBAction

    @objc private func selectType(_ sender: UISegmentedControl) {
        print("Тыц")
    }

    // MARK: - Private Methods

    private func configureUI() {
        configureNavBar()
        configureView()
        configureChooseTypeMovieSegmentedControl()
        configureTableview()
    }

    private func configureView() {
        view.backgroundColor = .systemBackground
//        view.addSubview(chooseTypeMovieSegmentedControl)
    }

    private func configureNavBar() {
        title = Constants.title
    }

    private func configureChooseTypeMovieSegmentedControl() {
        chooseTypeMovieSegmentedControl = UISegmentedControl(items: movieTypes)
        chooseTypeMovieSegmentedControl.addTarget(self, action: #selector(selectType), for: .valueChanged)
        view.addSubview(chooseTypeMovieSegmentedControl)
        chooseTypeMovieSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chooseTypeMovieSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chooseTypeMovieSegmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor),
            chooseTypeMovieSegmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor),
            chooseTypeMovieSegmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            chooseTypeMovieSegmentedControl.heightAnchor.constraint(equalToConstant: Constants.heightTypeMovieSC)
        ])
    }

    private func configureTableview() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: Constants.movieIdentifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: chooseTypeMovieSegmentedControl.bottomAnchor),
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
        cell.configure(model: movies[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.bounds.height / 4
    }
}

extension HomeViewController: UITableViewDelegate {}
