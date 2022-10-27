// DetailViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Описание детальной информации по фильму
final class DetailViewController: UIViewController {
    private enum Constants {
        static let backgroundView = "backGround"
        static let emptyString = ""
        static let cast = "В ролях:"
        static let noCast = "И актеров тут нет(("
    }

    // MARK: - Private Visual Components

    private var backgroundView = UIImageView()
    private let posterImageView = UIImageView()
    private let castImageView = UIImageView()
    private let descriptionLabel = UILabel()
    private let castLabel = UILabel()
    private let movieDetailScrollVew = UIScrollView()

    // MARK: - Public Properties

    var id = Constants.emptyString
    var imageName = Constants.emptyString
    var movieName = Constants.emptyString
    var movieDescription = Constants.emptyString
    var actorNames = [Constants.emptyString]
    var actorImageNames: [String] = [Constants.emptyString]

    // MARK: - Private Properties

    var networkManager = NetworkManager()
    var keyTiser = String()
    var tiser: [TiserDetail] = []

    // MARK: - Initializers

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchTiserUrl()
    }

    // MARK: - Public Methods

    // MARK: - Private IBAction

    @objc private func handleTapAction(_ recognizer: UIGestureRecognizer) {
        let selectVC = TiserViewController()
        let barButtonItem = UIBarButtonItem()
        navigationItem.backBarButtonItem = barButtonItem
        selectVC.videoUrl = keyTiser
        navigationController?.pushViewController(selectVC, animated: true)
//        networkManager.fetchTiserResult(id) { tiserInfo in
//            DispatchQueue.main.async {
//                guard let result = try? tiserInfo.get().results else { return }
//                // tiser = result
//                selectVC.videoUrl = keyTiser
//            }
//        }
    }

    // MARK: - Private Methods

    private func fetchTiserUrl() {
        networkManager.fetchTiserResult(id) { tiserInfo in
            DispatchQueue.main.async {
                guard let result = try? tiserInfo.get().results else { return }
                self.keyTiser = result.first?.key ?? ""
                print(self.keyTiser)
            }
        }
    }

//    private func createActors() {
//           var yyyy = 0
//           let image = UIImageView()
//           for actor in actorImageNames {
//               image.loadImage(baseUrlString: Url.imagePath, urlImage: actor)
//               view.addSubview(image)
//               image.frame = CGRect(x: 0, y: yyyy, width: 50, height: 50)
//               yyyy += 10
//           }
//       }
//
    private func configureUI() {
        setBackgroundImage()
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
        posterImageView.clipsToBounds = true
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        movieDetailScrollVew.addSubview(posterImageView)
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: movieDetailScrollVew.topAnchor, constant: 10),
            posterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            posterImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(handleTapAction))
        posterImageView.isUserInteractionEnabled = true
        posterImageView.addGestureRecognizer(recognizer)
    }

    private func configureDescriptionLabel() {
        descriptionLabel.text = movieDescription
        descriptionLabel.textAlignment = .justified
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        movieDetailScrollVew.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
        ])
    }

    private func configureCastLabel() {
        if actorNames.count == 0 {
            castLabel.text = Constants.noCast
        } else {
            castLabel.text = Constants.cast
        }
        castLabel.textAlignment = .center
        castLabel.translatesAutoresizingMaskIntoConstraints = false
        movieDetailScrollVew.addSubview(castLabel)
        NSLayoutConstraint.activate([
            castLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
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
        configureDescriptionLabel()
        configureCastLabel()
        var actors: [ActorView] = []
        for (index, actorDetails) in actorNames.enumerated() {
            let actor = ActorView()
            actor.configureView(actorDetails, actorImageNames[index])
            actors.append(actor)
        }

        var yCoord = view.bounds.height / 2 + 90
        if descriptionLabel.text?.count != 0 {
            yCoord += Double((descriptionLabel.text?.count ?? 0) / 28 * 20)
        }
        for actor in actors {
            actor.frame = CGRect(x: 0, y: yCoord, width: view.bounds.width, height: view.bounds.width)
            movieDetailScrollVew.addSubview(actor)
            yCoord += view.bounds.width - 50
        }
        movieDetailScrollVew.contentSize = CGSize(width: view.bounds.width, height: yCoord)
    }
}
