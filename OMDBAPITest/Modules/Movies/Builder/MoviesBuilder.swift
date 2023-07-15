import UIKit
import Swinject

protocol MoviesBuilderProtocol {
    func buildViewController() -> MoviesViewController!
}

class MoviesBuilder: MoviesBuilderProtocol {
    let container = AppContainer.default
    
    func buildViewController() -> MoviesViewController! {
        container.register(MoviesViewController.self) { _ in
            MoviesBuilder.instantiateViewController()
            
        }.initCompleted { r, h in
            h.presenter = r.resolve(MoviesPresenter.self)
        }
        
        container.register(MoviesPresenter.self) { c in
            let moviesService = c.resolve(MoviesServiceProtocol.self)!
            let imageDownloaderManager = c.resolve(ImageDownloaderManagerProtocol.self)!
            return MoviesPresenter(view: c.resolve(MoviesViewController.self)!,
                                   moviesService: moviesService,
                                   imageDownloaderManager: imageDownloaderManager)
        }
        
        return container.resolve(MoviesViewController.self)!
    }
    
    deinit {
        container.removeAll()
    }
    
    private static func instantiateViewController() -> MoviesViewController {
        let identifier = String(describing: MoviesViewController.self)
        let storyboard = UIStoryboard(name: identifier, bundle: .main)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! MoviesViewController
    }
}
