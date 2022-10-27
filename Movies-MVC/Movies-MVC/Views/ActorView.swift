// ActorView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Вью информации по актеру
final class ActorView: UIView {
    // MARK: - Private IBoutlet

    // MARK: - Private Visual Components

    private let actorImageView = UIImageView()
    private let actorNameLabel = UILabel()

    // MARK: - Public Properties

    // MARK: - Private Properties

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func configureView(_ name: String, _ imageUrl: String) {
        actorImageView.loadImage(baseUrlString: Url.imagePath, urlImage: imageUrl)
        actorNameLabel.text = name
    }

    // MARK: - Private IBAction

    // MARK: - Private Methods

    private func configureUI() {
        configurePosterImageView()
        configureActorNameLabel()
    }

    private func configurePosterImageView() {
        actorImageView.contentMode = .scaleAspectFill
        actorImageView.clipsToBounds = true
        actorImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(actorImageView)
        NSLayoutConstraint.activate([
            actorImageView.topAnchor.constraint(equalTo: topAnchor),
            actorImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            actorImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            actorImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7)
        ])
    }

    private func configureActorNameLabel() {
        actorNameLabel.textAlignment = .center
        actorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        actorNameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        addSubview(actorNameLabel)
        NSLayoutConstraint.activate([
            actorNameLabel.topAnchor.constraint(equalTo: actorImageView.bottomAnchor, constant: 10),
            actorNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            actorNameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            // descriptionLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
    }
}
