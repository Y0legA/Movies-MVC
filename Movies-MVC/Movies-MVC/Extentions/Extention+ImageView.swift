// Extention+ImageView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIImageView {
    func loadImage(baseUrlString: String, urlImage: String) {
        image = nil
        let imageUrl = baseUrlString + urlImage
        if let url = URL(string: imageUrl) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                guard let self else { return }
                DispatchQueue.main.async {
                    if let data {
                        if let image = UIImage(data: data) {
                            self.image = image
                        } else {
                            self.image = UIImage(named: "noPhoto")
                        }
                    }
                }
            }.resume()
        }
    }
}
