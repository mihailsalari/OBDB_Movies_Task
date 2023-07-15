import UIKit
import Swinject

protocol SplashBuilderProtocol {
  func buildViewController() -> SplashViewController!
}

class SplashBuilder: SplashBuilderProtocol {
  let container = Container()

  func buildViewController() -> SplashViewController! {
    container.register(SplashViewController.self) { _ in
      SplashBuilder.instantiateViewController()

    }.initCompleted { r, h in
      h.presenter = r.resolve(SplashPresenter.self)
    }

    container.register(SplashPresenter.self) { c in
      SplashPresenter(view: c.resolve(SplashViewController.self)!)
    }

    return container.resolve(SplashViewController.self)!
  }

  deinit {
    container.removeAll()
  }

  private static func instantiateViewController() -> SplashViewController {
    let identifier = String(describing: SplashViewController.self)
    let storyboard = UIStoryboard(name: identifier, bundle: .main)
    return storyboard.instantiateViewController(withIdentifier: identifier) as! SplashViewController
  }
}
