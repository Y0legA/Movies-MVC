// MovieTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Ячейка фильма домашнего экрана
final class MovieTableViewCell: UITableViewCell {
    private enum Constants {
        static let title = "Movies"
        static let movieIdentifier = "movie"
        static let fontArial = "Arial"
        static let height = 30.0
    }

    // MARK: Visual Properties

    private let contView = UIView()
    private let movieImageView = UIImageView()
    private let movieNameLabel = UILabel()
    private let movieDescriptionLabel = UILabel()
    private let ratingLabel = UILabel()
    private let reliseLabel = UILabel()

    // Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods

    func configure(model: MovieInfo) {
        movieImageView.image = UIImage(named: model.name)
        movieNameLabel.text = model.text
        movieDescriptionLabel.text = model.description
        ratingLabel.text = model.rating
        reliseLabel.text = model.relize
    }

    // MARK: Private Methods

    private func configureUI() {
        configureContentView()
        configureMovieImageView()
        configureMovieNameLabel()
        configureMovieDescriptionLabel()
        configureRatingLabel()
        configureRelizeLabel()
    }

    private func configureContentView() {
        selectionStyle = .none
        addSubview(contView)
        contView.translatesAutoresizingMaskIntoConstraints = false
        contView.layer.cornerRadius = 20
        contView.clipsToBounds = true
        contView.layer.borderColor = UIColor.cyan.cgColor
        contView.layer.borderWidth = 2
        NSLayoutConstraint.activate([
            contView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            contView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            contView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            contView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func configureMovieImageView() {
        contView.addSubview(movieImageView)
        movieImageView.contentMode = .scaleToFill
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: contView.topAnchor),
            movieImageView.leftAnchor.constraint(equalTo: contView.leftAnchor),
            movieImageView.widthAnchor.constraint(equalTo: contView.widthAnchor, multiplier: 0.3),
            movieImageView.heightAnchor.constraint(equalTo: contView.heightAnchor)
        ])
    }

    private func configureMovieNameLabel() {
        contView.addSubview(movieNameLabel)
        movieNameLabel.font = UIFont.avenirNextDemiBold20()
        movieNameLabel.textAlignment = .center
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieNameLabel.topAnchor.constraint(equalTo: contView.topAnchor, constant: 10),
            movieNameLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor),
            movieNameLabel.trailingAnchor.constraint(equalTo: contView.trailingAnchor),
            movieNameLabel.heightAnchor.constraint(equalTo: contView.heightAnchor, multiplier: 0.1)
        ])
    }

    private func configureMovieDescriptionLabel() {
        contView.addSubview(movieDescriptionLabel)
        movieDescriptionLabel.font = UIFont.avenirNext14()
        movieDescriptionLabel.numberOfLines = 0
        movieDescriptionLabel.textAlignment = .justified
        movieDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieDescriptionLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor),
            movieDescriptionLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            movieDescriptionLabel.trailingAnchor.constraint(equalTo: contView.trailingAnchor, constant: -10),
            movieDescriptionLabel.heightAnchor.constraint(equalTo: contView.heightAnchor, multiplier: 0.7)
        ])
    }

    private func configureRatingLabel() {
        contView.addSubview(ratingLabel)
        ratingLabel.textAlignment = .left
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: movieDescriptionLabel.bottomAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            ratingLabel.widthAnchor.constraint(equalTo: movieDescriptionLabel.widthAnchor, multiplier: 0.5),
            // ratingLabel.heightAnchor.constraint(equalTo: contView.heightAnchor, multiplier: 0.1),
            ratingLabel.bottomAnchor.constraint(equalTo: contView.bottomAnchor, constant: -10)
        ])
    }

    private func configureRelizeLabel() {
        contView.addSubview(reliseLabel)
        reliseLabel.textAlignment = .right
        reliseLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reliseLabel.topAnchor.constraint(equalTo: movieDescriptionLabel.bottomAnchor),
            reliseLabel.trailingAnchor.constraint(equalTo: contView.trailingAnchor, constant: -10),
            reliseLabel.widthAnchor.constraint(equalTo: ratingLabel.widthAnchor),
            // reliseLabel.heightAnchor.constraint(equalTo: ratingLabel.heightAnchor),
            reliseLabel.bottomAnchor.constraint(equalTo: ratingLabel.bottomAnchor)
        ])
    }
}
