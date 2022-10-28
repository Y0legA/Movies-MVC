// Extention+ImageView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIImageView {
    func loadImage(baseUrlString: String, urlImage: String) {
        image = nil
        let imageUrl = baseUrlString + urlImage
        guard let url = URL(string: imageUrl) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self else { return }
            DispatchQueue.main.async {
                guard let data else { return }
                if let image = UIImage(data: data) {
                    self.image = image
                } else {
                    self.image = UIImage(named: "noPhoto")
                }
            }
        }.resume()
    }
}
