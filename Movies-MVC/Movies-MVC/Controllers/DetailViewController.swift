// DetailViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Описание детальной информации по фильму
final class DetailViewController: UIViewController {
    // MARK: - Private Visual Components

    private let posterImageView = UIImageView()
    private let testImageView = UIImageView()
    private let descriptionLabel = UILabel()
    private let actorsDetailScrollVew = UIScrollView()

    // MARK: - Public Properties

    var imageName = ""
    var movieName = ""
    var movieDescription = ""
    var actorNames = [""]
    var actorImageNames: [String] = [""] {
        didSet {
            createActors()
            print(actorImageNames.count)
        }
    }

    var images: [UIImageView] = []
//     var testImage: UIImageView = .init(image: UIImage(named: ""))

    // MARK: - Private Properties

    // MARK: - Initializers

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Public Methods

    // MARK: - Private IBAction

    private func createActors() {
        var yyyy = 0
        let image = UIImageView()
        for actor in actorImageNames {
            image.loadImage(baseUrlString: Url.imagePath, urlImage: actor)
            view.addSubview(image)
            image.frame = CGRect(x: 0, y: yyyy, width: 50, height: 50)
            yyyy += 10
        }
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .systemMint
        configurePosterImageView()
        configureDescriptionLabel()
        configureTestView()
//        createActors()
    }

    private func configurePosterImageView() {
        posterImageView.loadImage(baseUrlString: Url.imagePath, urlImage: imageName)
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(posterImageView)
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            posterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            posterImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
    }

    private func configureDescriptionLabel() {
        descriptionLabel.text = movieDescription
        descriptionLabel.textAlignment = .justified
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            // descriptionLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
    }

    private func configureActorsDetailScrollVew() {
        NSLayoutConstraint.activate([
            actorsDetailScrollVew.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            testImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            testImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func configureTestView() {
        testImageView.loadImage(baseUrlString: Url.imagePath, urlImage: actorImageNames[5])
        testImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(testImageView)
        NSLayoutConstraint.activate([
            testImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            testImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            testImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
    }
}
