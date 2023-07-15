import UIKit

protocol MoviesPresenterProtocol {
    func present()
    func didSelect(viewModel: MoviesViewModel)
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
                let viewModels = movies.search.compactMap { MoviesViewModel(with: $0) }
                DispatchQueue.main.async {
                    self?.view.prepare(with: viewModels)
                    self?.downloadPostersImages(for: viewModels)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }

    private func downloadPostersImages(for viewModels: [MoviesViewModel]) {
        view.showLoading(with: "Loading...")
        
        let dispatchGroup = DispatchGroup()
        
        var updatedViewModels: [MoviesViewModel] = []
        
        for viewModel in viewModels {
            dispatchGroup.enter()
            
            imageDownloaderManager.downloadImage(for: viewModel.imageURLString) { [weak self] result in
                switch result {
                case .success(let imageData):
                    self?.downloadMovieDetails(movieId: viewModel.id) { detailsResult in
                        switch detailsResult {
                        case .success(let details):
                            var tmpViewModel = viewModel
                            tmpViewModel.details = details
                            tmpViewModel.duration = details.runtime
                            tmpViewModel.posterData = imageData
                            tmpViewModel.rating = details.ratings.first?.value ?? "\(details.imdbRating)/10.0"
                            
                            updatedViewModels.append(tmpViewModel)
                        case .failure(let failure):
                            print("Cannot download details, failed: \(failure.localizedDescription)")
                        }
                        
                        dispatchGroup.leave()
                    }
                case .failure(let error):
                    print("Image download failed: \(error)")
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.view.hideLoading()
            self?.view.prepare(with: updatedViewModels)
        }
    }

    private func downloadMovieDetails(movieId: String, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        let parameters: [String: Any] = [
            "i": movieId,
            "plot": "full",
            "apikey": "86c4b2d9"
        ]
        
        // https://www.omdbapi.com/?i=tt0372784&plot=full&apikey=86c4b2d9
        moviesService.getMovieDetail(with: Constants.apiBaseURL, parameters: parameters, completion: completion)
    }
    
    func didSelect(viewModel: MoviesViewModel) {
        guard let details = viewModel.details, let posterData = viewModel.posterData else { return }
        navigateToDetail(with: details, posterData: posterData)
    }
    
    
    private func navigateToDetail(with detail: MovieDetail, posterData: Data) {
        let controller = MovieDetailBuilder().buildViewController(with: detail, posterData: posterData)!
        view.navigationController?.pushViewController(controller, animated: true)
    }
}
