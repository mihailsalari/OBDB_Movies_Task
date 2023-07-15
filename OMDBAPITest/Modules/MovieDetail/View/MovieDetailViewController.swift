import UIKit

protocol MovieDetailViewControllerProtocol: AnyObject {
    func prepare(with viewModel: MovieDetailViewModel)
}

final class MovieDetailViewController: UIViewController, MovieDetailViewControllerProtocol {
    var presenter: MovieDetailPresenterProtocol!
    
    @IBOutlet private weak var gradientView: GradientView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var detailTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        presenter.present()
        setupViews()
    }
    
    private func setupViews() {
        gradientView.backgroundColor = UIColor.clear
        
        detailTextView.textColor = .white
        detailTextView.backgroundColor = .clear
        detailTextView.isEditable = false
        detailTextView.textContainerInset = UIEdgeInsets(top: 42, left: 0, bottom: 0, right: 0)
    }
    
    func prepare(with viewModel: MovieDetailViewModel) {
        imageView.image = UIImage(data: viewModel.posterData)
        detailTextView.attributedText = viewModel.detailsAttributedText
    }
}
