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
    @IBOutlet private weak var yearImgView: UIImageView!
    
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var durationImgView: UIImageView!
    
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var ratingImgView: UIImageView!
    
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var typeImgView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .black
        
        nameLabel.isHidden = true
        nameLabel.textColor = .white

        yearLabel.textColor = .white.withAlphaComponent(0.8)
        yearLabel.isHidden = true
        yearImgView.isHidden = true
        
        durationLabel.textColor = .white.withAlphaComponent(0.8)
        durationLabel.isHidden = true
        durationImgView.isHidden = true
        
        ratingLabel.textColor = .white.withAlphaComponent(0.8)
        ratingLabel.isHidden = true
        ratingImgView.isHidden = true
        
        typeLabel.textColor = .white.withAlphaComponent(0.8)
        typeLabel.isHidden = true
        typeImgView.isHidden = true
        
        spinner.color = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with viewModel: MoviesViewModel) {
        nameLabel.text = viewModel.title
        nameLabel.isHidden = false
        
        if !viewModel.year.isEmpty {
            yearLabel.isHidden = false
            yearLabel.text = viewModel.year
            yearImgView.isHidden = false
        }
        
        if let text = viewModel.duration {
            durationLabel.isHidden = false
            durationLabel.text = text
            durationImgView.isHidden = false
        }
        
        if let text = viewModel.rating {
            ratingLabel.isHidden = false
            ratingLabel.text = text
            ratingImgView.isHidden = false
        }
        
        if !viewModel.type.isEmpty {
            typeLabel.isHidden = false
            typeLabel.text = viewModel.type
            typeImgView.isHidden = false
        }
        
        if let posterImage = viewModel.posterData {
            imgView.image = UIImage(data: posterImage)
            spinner.stopAnimating()
        } else {
            spinner.startAnimating()
        }
    }
}
