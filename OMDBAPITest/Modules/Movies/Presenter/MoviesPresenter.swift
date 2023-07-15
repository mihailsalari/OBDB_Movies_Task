import UIKit

protocol MoviesPresenterProtocol {
    func present()
    func didSelect(movieId: String?, posterData: Data?)
}

class MoviesPresenter: MoviesPresenterProtocol {
    private struct Constants {
        static let apiBaseURL = "https://www.omdbapi.com"
    }
    private weak var view: (MoviesViewControllerProtocol & UIViewController)!
    
    private let moviesService: MoviesServiceProtocol
    private let imageDownloaderManager: ImageDownloaderManagerProtocol
    
    init(view: MoviesViewControllerProtocol & UIViewController, moviesService: MoviesServiceProtocol,
         imageDownloaderManager: ImageDownloaderManagerProtocol) {
        self.view = view
        self.moviesService = moviesService
        self.imageDownloaderManager = imageDownloaderManager
    }
    
    func present() {
        let parameters: [String: Any] = [
            "s": "Batman",
            "page": 1,
            "apikey": "86c4b2d9"
        ]
        
        moviesService.getMovies(with: Constants.apiBaseURL, parameters: parameters) { [weak self] (result: Result<MovieResult, Error>) in
            switch result {
            case .success(let movies):
                let viewModel = MoviesViewModel(movieResult: movies)
                DispatchQueue.main.async {
                    self?.view.prepare(with: viewModel)
                    self?.downloadPostersImages(for: viewModel)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func downloadPostersImages(for moviesViewModel: MoviesViewModel) {
        view.showLoading(with: "Loading...")
        let searchResults = moviesViewModel.movieResult.search
        
        let dispatchGroup = DispatchGroup()
        
        var updatedSearchResults: [MovieSearch] = []
        
        for item in searchResults {
            dispatchGroup.enter()
            
            imageDownloaderManager.downloadImage(for: item.poster) { [weak self] result in
                switch result {
                case .success(let imageData):
                    let searchResult = MovieSearch(title: item.title, year: item.year,
                                                   imdbID: item.imdbID, type: item.type,
                                                   poster: item.poster, posterImage: imageData)
                    updatedSearchResults.append(searchResult)
                case .failure(let error):
                    print("Image download failed: \(error)")
                    self?.view.hideLoading()
                }
                
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            var updatedMoviesViewModel = moviesViewModel
            updatedMoviesViewModel.movieResult.search = updatedSearchResults
            
            self?.view.hideLoading()
            // Update the view with the updated view model and downloaded images
            self?.view.prepare(with: updatedMoviesViewModel)
        }
    }
    
    func didSelect(movieId: String?, posterData: Data?) {
        guard let movieId = movieId, !movieId.isEmpty, let posterData = posterData else { return }
        
        view.navigationController?.showLoading(with: "Loading...")

        let parameters: [String: Any] = [
            "i": movieId,
            "plot": "full",
            "apikey": "86c4b2d9"
        ]
        
        // https://www.omdbapi.com/?i=tt0372784&plot=full&apikey=86c4b2d9
        moviesService.getMovieDetail(with: Constants.apiBaseURL, parameters: parameters) { [weak self] (result: Result<MovieDetail, Error>) in
            switch result {
            case .success(let detail):
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self?.view.hideLoading()
                    self?.navigateToDetail(with: detail, posterData: posterData)
                }
            case .failure(let failure):
                print(failure)
                self?.view.hideLoading()
            }
        }
    }
    
    private func navigateToDetail(with detail: MovieDetail, posterData: Data) {
        let controller = MovieDetailBuilder().buildViewController(with: detail, posterData: posterData)!
        view.navigationController?.pushViewController(controller, animated: true)
    }
}
