import UIKit

protocol SplashPresenterProtocol {
    func present()
}

class SplashPresenter: SplashPresenterProtocol {
    private weak var view: (SplashViewControllerProtocol & UIViewController)!
    
    init(view: SplashViewControllerProtocol & UIViewController) {
        self.view = view
    }
    
    func present() {
        let controller = MoviesBuilder().buildViewController()!
        let navigation = BaseNavigationController(rootViewController: controller)
        navigation.modalPresentationStyle = .fullScreen
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.view.present(navigation, animated: false)
        }
    }
}
