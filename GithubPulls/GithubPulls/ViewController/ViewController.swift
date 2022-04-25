import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var viewModel: PullListViewModel = PullListViewModelImpl()
    
    private lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = UITableView.automaticDimension
        tableview.register(PullRequestTableViewCell.self, forCellReuseIdentifier: PullRequestTableViewCell.reusableIdentifier)
        return tableview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        setupCallback()
        setUpConstraints()
        viewModel.fetchClosedPullsList()
    }
    
    private func setupView() {
        view.addSubview(tableView)
        view.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupCallback() {
        viewModel.resultsFetched = { [weak self] in
            DispatchQueue.main.async {
                self?.reLoadList()
            }
        }
    }
    
    private func setUpConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        NSLayoutConstraint.activate(constraints)
    }

    private func reLoadList() {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pullDetails?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PullRequestTableViewCell.reusableIdentifier, for: indexPath) as? PullRequestTableViewCell else {
            fatalError()
        }
        let cellViewModel = viewModel.getCellViewModel(for: indexPath.row)
        cell.updateCell(with: cellViewModel)
        return cell
    }
}
