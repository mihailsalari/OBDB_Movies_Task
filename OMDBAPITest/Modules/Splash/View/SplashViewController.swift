import UIKit

protocol SplashViewControllerProtocol: AnyObject {
  func prepare(with viewModel: SplashViewModel)
}

class SplashViewController: UIViewController, SplashViewControllerProtocol {
  var presenter: SplashPresenterProtocol!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    presenter.present()
    setupViews()
  }

  private func setupViews() {
    // Setup views
  }

  func prepare(with viewModel: SplashViewModel) {
    title = viewModel.title
  }
}
