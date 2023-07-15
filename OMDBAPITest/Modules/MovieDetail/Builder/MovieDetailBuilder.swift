import UIKit
import Swinject

protocol MovieDetailBuilderProtocol {
    func buildViewController(with detail: MovieDetail, posterData: Data) -> MovieDetailViewController!
}

class MovieDetailBuilder: MovieDetailBuilderProtocol {
    let container = Container()
    
    func buildViewController(with detail: MovieDetail, posterData: Data) -> MovieDetailViewController! {
        container.register(MovieDetailViewController.self) { _ in
            MovieDetailBuilder.instantiateViewController()
            
        }.initCompleted { r, h in
            h.presenter = r.resolve(MovieDetailPresenter.self)
        }
        
        container.register(MovieDetailPresenter.self) { c in
            MovieDetailPresenter(view: c.resolve(MovieDetailViewController.self)!, detail: detail, posterData: posterData)
        }
        
        return container.resolve(MovieDetailViewController.self)!
    }
    
    deinit {
        container.removeAll()
    }
    
    private static func instantiateViewController() -> MovieDetailViewController {
        let identifier = String(describing: MovieDetailViewController.self)
        let storyboard = UIStoryboard(name: identifier, bundle: .main)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! MovieDetailViewController
    }
}
