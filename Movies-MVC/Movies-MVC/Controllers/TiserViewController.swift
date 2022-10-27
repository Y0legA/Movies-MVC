// TiserViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
import WebKit

// Экран тизера
final class TiserViewController: UIViewController {
    // MARK: - Private IBoutlet

    private lazy var webView: WKWebView = {
        let webWiew = WKWebView(frame: CGRect(origin: CGPoint(x: view.bounds.minX, y: 60), size: view.bounds.size))
        return webWiew
    }()

    // MARK: - Private Visual Components

    // MARK: - Public Properties

    var videoUrl = String()

    // MARK: - Private Properties

    // MARK: - Initializers

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // view.backgroundColor = .green
        view.addSubview(webView)
        configureWebView()
        // configureUI()
    }

    // MARK: - Public Methods

    // MARK: - Private IBAction

    // MARK: - Private Methods

    private func configureWebView() {
        webView.navigationDelegate = self
        let url = URL(string: Url.youTube + videoUrl)

        guard let url = url else { return }
        print(url)
        let request = URLRequest(url: url)
        webView.load(request)
        //           observation = webView.observe(
        //               \.estimatedProgress,
        //                options: [.new],
        //                changeHandler: { [weak self] webView, _ in
        //                    guard let self = self else { return }
        //                    self.progressView.progress = Float(webView.estimatedProgress * 2)
        //                    return
        //                })
    }
}

extension TiserViewController: WKNavigationDelegate {}
