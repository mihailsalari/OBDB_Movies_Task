import UIKit

protocol MoviesViewControllerProtocol: AnyObject {
    func prepare(with viewModels: [MoviesViewModel])
}

final class MoviesViewController: UITableViewController, MoviesViewControllerProtocol {
    var presenter: MoviesPresenterProtocol!
    private var viewModels: [MoviesViewModel] = []
    
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
    
    func prepare(with viewModels: [MoviesViewModel]) {
        self.viewModels = viewModels
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
}

extension MoviesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.reuseIdentifier, for: indexPath) as? MoviesTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
}

extension MoviesViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(viewModel: viewModels[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220.0
    }
}
