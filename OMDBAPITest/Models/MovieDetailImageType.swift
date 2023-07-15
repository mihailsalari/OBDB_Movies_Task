//
//  MovieDetailImageType.swift
//  OMDBAPITest
//
//  Created by Mihail Salari on 7/15/23.
//

import UIKit

enum MovieDetailImageType: String {
    case rating = "star.fill"
    case votes = "hand.thumbsup.circle.fill"
    case releaseDate = "calendar.circle.fill"
    case duration = "clock.fill"
    case type = "tv.circle.fill"
    case genre = "film.circle.fill"
    case director = "person.circle.fill"
    case writer = "pencil.circle.fill"
    case actors = "person.2.circle.fill"
    case plot = "newspaper.circle.fill"
    case language = "flag.circle.fill"
    case country = "location.circle.fill"
    case awards = "trophy.circle.fill"
    case metascore = "sportscourt.circle.fill"
    case dvd = "airplayaudio.circle.fill"
    case boxOffice = "dollarsign.circle.fill"
    case production = "play.circle.fill"
    case website = "safari.fill"
    
    var image: UIImage? {
        UIImage(system: self.rawValue)
    }
}

extension UIImage {
    convenience init?(system: String, fontSize: CGFloat = 18.0, weight: UIImage.SymbolWeight = .regular) {
        let configuration = UIImage.SymbolConfiguration(pointSize: fontSize, weight: weight)
        self.init(systemName: system, withConfiguration: configuration)
    }
}
