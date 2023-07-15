import UIKit

protocol MovieDetailPresenterProtocol {
    func present()
}

final class MovieDetailPresenter: MovieDetailPresenterProtocol {
    private weak var view: (MovieDetailViewControllerProtocol & UIViewController)!
    
    private let detail: MovieDetail
    private let posterData: Data
    
    init(view: MovieDetailViewControllerProtocol & UIViewController, detail: MovieDetail, posterData: Data) {
        self.view = view
        self.detail = detail
        self.posterData = posterData
    }
    
    func present() {
        let viewModel = MovieDetailViewModel(detailsAttributedText: createTextViewAttributedString(with: detail), posterData: posterData)
        view.prepare(with: viewModel)
    }
    
    private func createTextViewAttributedString(with detail: MovieDetail) -> NSAttributedString {
        let titleText = detail.title
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 24)
        ]
        let titleAttributedString = NSAttributedString(string: titleText + "\n", attributes: titleAttributes)
        
        let attributedString = NSMutableAttributedString()
        attributedString.append(titleAttributedString)
        
        let sections: [MovieDetailSectionType] = [
            .rating(image: .rating, text: "Rating: \(detail.ratings.first?.value ?? "\(detail.imdbRating)/10.0")"),
            .general(image: .votes, text: "Votes: \(detail.imdbVotes)"),
            .general(image: .releaseDate, text: "Year: \(detail.year). Release date: \(detail.released)"),
            .general(image: .duration, text: "Duration: \(detail.runtime)"),
            .other(image: .type, text: "Type: \(detail.type)"),
            .other(image: .genre, text: "Genre: \(detail.genre)"),
            .other(image: .director, text: "Director: \(detail.director)"),
            .other(image: .writer, text: "Writer: \(detail.writer)"),
            .other(image: .actors, text: "Actors: \(detail.actors)"),
            .plot(image: .plot, text: "\(detail.plot)", font: UIFont.systemFont(ofSize: 16)),
            .other(image: .language, text: "Language: \(detail.language)"),
            .other(image: .country, text: "Country: \(detail.country)"),
            .other(image: .awards, text: "Awards: \(detail.awards)"),
            .other(image: .metascore, text: "Metascore: \(detail.metascore)"),
            .general(image: .dvd, text: "DVD: \(detail.dvd ?? "")"),
            .general(image: .boxOffice, text: "BoxOffice: \(detail.boxOffice ?? "")"),
            .general(image: .production, text: "Production: \(detail.production ?? "")"),
            .general(image: .website, text: "Website: \(detail.website ?? "")")
        ]

        for section in sections {
            if let attributed = section.attributedString {
                attributedString.append(attributed)
            }
        }

        return attributedString
    }
}
