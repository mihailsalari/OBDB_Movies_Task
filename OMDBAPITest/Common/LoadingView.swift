//
//  LoadingView.swift
//  OMDBAPITest
//
//  Created by Mihail Salari on 7/15/23.
//

import UIKit

final class LoadingView: UIView {
    private let stackView = UIStackView()
    private let spinnerView = UIActivityIndicatorView(style: .large)
    private let label = UILabel()
    
    init(title: String) {
        super.init(frame: .zero)
        setupViews(title: title)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews(title: "")
    }
    
    private func setupViews(title: String) {
        // Apply blur background
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // Stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 22
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // Spinner view
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        spinnerView.color = .white
        spinnerView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        spinnerView.startAnimating()
        stackView.addArrangedSubview(spinnerView)
        
        // Label
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.textColor = .white
        stackView.addArrangedSubview(label)
    }
    
    func show(in view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func hide() {
        removeFromSuperview()
    }
}


extension UIViewController {
    private static var loadingView: LoadingView?
    
    func showLoading(with title: String) {
        // Check if the loading view is already displayed
        if let loadingView = view.subviews.first(where: { $0.accessibilityIdentifier == "loadingView"}) as? LoadingView {
            UIViewController.loadingView = loadingView
            return
        }
        
        let loadingView = LoadingView(title: title)
        UIViewController.loadingView = loadingView
        loadingView.accessibilityIdentifier = "loadingView"
        let view = navigationController?.view ?? view
        view?.addSubview(loadingView)

        loadingView.show(in: view!)
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: view!.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view!.trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: view!.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view!.bottomAnchor)
        ])
    }
    
    func hideLoading() {
        UIViewController.loadingView?.removeFromSuperview()
    }
}
