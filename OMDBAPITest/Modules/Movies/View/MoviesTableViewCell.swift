//
//  MoviesTableViewCell.swift
//  OMDBAPITest
//
//  Created by Mihail Salari on 7/15/23.
//

import UIKit

final class MoviesTableViewCell: UITableViewCell {
    static let reuseIdentifier = String(describing: MoviesTableViewCell.self)

    @IBOutlet private weak var imgView: UIImageView!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!

    @IBOutlet private weak var nameLabel: UILabel!

    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .black
        
        nameLabel.textColor = .white

        yearLabel.textColor = .white.withAlphaComponent(0.8)
        durationLabel.textColor = .white.withAlphaComponent(0.8)
        ratingLabel.textColor = .white.withAlphaComponent(0.8)
        typeLabel.textColor = .white.withAlphaComponent(0.8)
        
        spinner.color = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with movieSearch: MovieSearch) {
        nameLabel.text = movieSearch.title

        yearLabel.text = movieSearch.year
        typeLabel.text = movieSearch.type.rawValue.capitalized
        
        
        if let posterImage = movieSearch.posterImage {
            imgView.image = UIImage(data: posterImage)
            spinner.stopAnimating()
        } else {
            spinner.startAnimating()
        }
    }
}
