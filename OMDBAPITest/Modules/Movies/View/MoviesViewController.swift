import UIKit

protocol MoviesViewControllerProtocol: AnyObject {
    func prepare(with viewModel: MoviesViewModel)
}

final class MoviesViewController: UITableViewController, MoviesViewControllerProtocol {
    var presenter: MoviesPresenterProtocol!
    private var viewModel: MoviesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        presenter.present()
        setupViews()
    }
    
    private func setupViews() {
        title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .black
    }
    
    func prepare(with viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
}

extension MoviesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.movieResult.search.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.reuseIdentifier, for: indexPath) as? MoviesTableViewCell else {
            return UITableViewCell()
        }
        
        if let search = viewModel?.movieResult.search[indexPath.row] {
            cell.configure(with: search)
        }
        return cell
    }
}

extension MoviesViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieId = viewModel?.movieResult.search[indexPath.row].imdbID
        let posterData = viewModel?.movieResult.search[indexPath.row].posterImage
        presenter.didSelect(movieId: movieId, posterData: posterData)
    }
}
