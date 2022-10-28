// DetailViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Описание детальной информации по фильму
final class DetailViewController: UIViewController {
    private enum Constants {
        static let backgroundView = "backGround"
        static let star = "star.leadinghalf.filled"
        static let dateRelize = "Дата релиза"
        static let description = "-=Описание=-"
        static let cast = "В ролях:"
        static let noCast = "И актеров тут нет(("
        static let showTizer = "Показать тизер"
    }

    // MARK: - Private Visual Components

    private var backgroundView = UIImageView()
    private let posterImageView = UIImageView()
    private let ratingImageView = UIImageView()
    private let ratingLabel = UILabel()
    private let relizeLabel = UILabel()
    private let relizeTextLabel = UILabel()
    private let showTizerButton = UIButton()
    private let descriptionLabel = UILabel()
    private let descriptionTextLabel = UILabel()
    private let castImageView = UIImageView()
    private let castLabel = UILabel()
    private let movieDetailScrollVew = UIScrollView()

    // MARK: - Public Properties

    var id = String()
    var imageName = String()
    var movieName = String()
    var rating = Float()
    var relize = String()
    var movieDescription = String()
    var actorNames: [String] = .init()
    var actorImageNames: [String] = .init()

    // MARK: - Private Properties

    var networkManager = NetworkManager()
    var keyTiser = String()
    var tiser: [TiserDetail] = []
    var actors: [ActorView] = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var yCoord = castLabel.frame.maxY + 20
        for actor in actors {
            actor.frame = CGRect(x: 0, y: yCoord, width: view.bounds.width, height: view.bounds.width)
            movieDetailScrollVew.addSubview(actor)
            yCoord += view.bounds.width - 50
        }
        movieDetailScrollVew.contentSize = CGSize(width: view.bounds.width, height: yCoord)
    }
    
    // MARK: - Private IBAction

    @objc private func showTizerAction() {
        let selectVC = TiserViewController()
        let barButtonItem = UIBarButtonItem(systemItem: .close)
        navigationItem.backBarButtonItem = barButtonItem
        selectVC.videoUrl = keyTiser
        navigationController?.pushViewController(selectVC, animated: false)
    }

    // MARK: - Private Methods

    private func fetchTiserUrl() {
        networkManager.fetchTiserResult(id) { tiserInfo in
            DispatchQueue.main.async {
                guard let result = try? tiserInfo.get().results else { return }
                self.keyTiser = result.first?.key ?? String()
            }
        }
    }

    private func configureUI() {
        setBackgroundImage()
        fetchTiserUrl()
        configureActorsDetailScrollVew()
    }

    private func setBackgroundImage() {
        view.backgroundColor = .systemBackground
        view.addSubview(backgroundView)
        backgroundView = UIImageView(frame: CGRect(origin: .zero, size: view.bounds.size))
        backgroundView.image = UIImage(named: Constants.backgroundView)
    }

    private func configurePosterImageView() {
        posterImageView.loadImage(baseUrlString: Url.imagePath, urlImage: imageName)
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 10
        posterImageView.clipsToBounds = true
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        movieDetailScrollVew.addSubview(posterImageView)
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: movieDetailScrollVew.topAnchor, constant: 10),
            posterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            posterImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7)
        ])
    }

    private func configureRatingImageView() {
        ratingImageView.image = UIImage(systemName: Constants.star)
        ratingImageView.contentMode = .scaleAspectFill
        ratingImageView.translatesAutoresizingMaskIntoConstraints = false
        movieDetailScrollVew.addSubview(ratingImageView)
        NSLayoutConstraint.activate([
            ratingImageView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 25),
            ratingImageView.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: 50),
            ratingImageView.widthAnchor.constraint(equalToConstant: 20),
            ratingImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    private func configureRatingLabel() {
        ratingLabel.text = String(rating)
        ratingLabel.textAlignment = .center
        ratingLabel.font = UIFont.avenirNextDemiBold20()
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        movieDetailScrollVew.addSubview(ratingLabel)
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: ratingImageView.bottomAnchor, constant: 10),
            ratingLabel.centerXAnchor.constraint(equalTo: ratingImageView.centerXAnchor),
            ratingLabel.widthAnchor.constraint(equalToConstant: 50),
            ratingLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    private func configureRelizeLabel() {
        relizeLabel.text = Constants.dateRelize
        relizeLabel.textAlignment = .center
        relizeLabel.textColor = .systemGray
        relizeLabel.font = UIFont.avenirNext16()
        relizeLabel.translatesAutoresizingMaskIntoConstraints = false
        relizeLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        movieDetailScrollVew.addSubview(relizeLabel)
        NSLayoutConstraint.activate([
            relizeLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20),
            relizeLabel.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -30),
            relizeLabel.heightAnchor.constraint(equalToConstant: 30),
            relizeLabel.widthAnchor.constraint(equalToConstant: 120)
        ])
    }

    private func configureRelizeTextLabel() {
        relizeTextLabel.text = relize
        relizeTextLabel.textAlignment = .center
        relizeTextLabel.font = UIFont.avenirNextDemiBold20()
        relizeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        relizeTextLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        movieDetailScrollVew.addSubview(relizeTextLabel)
        NSLayoutConstraint.activate([
            relizeTextLabel.topAnchor.constraint(equalTo: relizeLabel.bottomAnchor),
            relizeTextLabel.trailingAnchor.constraint(equalTo: relizeLabel.trailingAnchor),
            relizeTextLabel.heightAnchor.constraint(equalToConstant: 30),
            relizeTextLabel.widthAnchor.constraint(equalToConstant: 120)
        ])
    }

    private func configureShowTizerButton() {
        showTizerButton.setTitle(Constants.showTizer, for: .normal)
        showTizerButton.backgroundColor = .systemBlue
        showTizerButton.layer.cornerRadius = 10
        showTizerButton.addTarget(self, action: #selector(showTizerAction), for: .touchUpInside)
        showTizerButton.translatesAutoresizingMaskIntoConstraints = false
        movieDetailScrollVew.addSubview(showTizerButton)
        NSLayoutConstraint.activate([
            showTizerButton.topAnchor.constraint(equalTo: relizeTextLabel.bottomAnchor, constant: 20),
            showTizerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showTizerButton.widthAnchor.constraint(equalTo: posterImageView.widthAnchor),
            showTizerButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func configureDescriptionLabel() {
        descriptionLabel.text = Constants.description
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.avenirNextDemiBold20()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        movieDetailScrollVew.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: showTizerButton.bottomAnchor, constant: 30),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
        ])
    }

    private func configureDescriptionTextLabel() {
        descriptionTextLabel.text = movieDescription
        descriptionTextLabel.textAlignment = .justified
        descriptionTextLabel.numberOfLines = 0
        descriptionTextLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        movieDetailScrollVew.addSubview(descriptionTextLabel)
        NSLayoutConstraint.activate([
            descriptionTextLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            descriptionTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionTextLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
        ])
    }

    private func configureCastLabel() {
        if actorNames.count == 0 {
            castLabel.text = Constants.noCast
        } else {
            castLabel.text = Constants.cast
        }
        castLabel.textAlignment = .center
        castLabel.font = UIFont.avenirNextDemiBold20()
        castLabel.translatesAutoresizingMaskIntoConstraints = false
        movieDetailScrollVew.addSubview(castLabel)
        NSLayoutConstraint.activate([
            castLabel.topAnchor.constraint(equalTo: descriptionTextLabel.bottomAnchor, constant: 30),
            castLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            castLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        ])
    }

    private func configureActorsDetailScrollVew() {
        movieDetailScrollVew.showsVerticalScrollIndicator = false
        view.addSubview(backgroundView)
        movieDetailScrollVew.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(movieDetailScrollVew)
        NSLayoutConstraint.activate([
            movieDetailScrollVew.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieDetailScrollVew.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieDetailScrollVew.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieDetailScrollVew.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        configurePosterImageView()
        configureRatingImageView()
        configureRatingLabel()
        configureRelizeLabel()
        configureRelizeTextLabel()
        configureShowTizerButton()
        configureDescriptionLabel()
        configureDescriptionTextLabel()
        configureCastLabel()
        for (index, actorDetails) in actorNames.enumerated() {
            let actor = ActorView()
            actor.configureView(actorDetails, actorImageNames[index])
            actors.append(actor)
        }
    }
}
