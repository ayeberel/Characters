//  Created by ayu on 05/08/21.

import UIKit

class MasterListViewController: UITableViewController {
    private var detailNavigationVCIdentifier = "DetailNavVCIdentifier"
    private var cellIdentifier = "cell"
    var viewModel: CharacterViewModelable!
    
    //Search bar
    let searchController = UISearchController(searchResultsController: nil)
    
    var isSearchEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return !isSearchEmpty && searchController.isActive
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CharacterListViewModel()
        viewModel.fetchData()
        viewModel.onCompletion = { [weak self] response in
            if response == nil {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } else {
                self?.setupAlertMessage()
            }
        }
        
        setupSearchController()
    }
    
    private func setupAlertMessage() {
        let alertVC = UIAlertController(title: "Error", message: Constants.somethingWrongError, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true, completion: nil)
    }
}

// MARK: - Table view data source & Delegate

extension MasterListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCharacters(isFiltering: isFiltering)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            cell.textLabel?.text = viewModel.getTitle(at: indexPath.row, isFiltering: isFiltering)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = viewModel.getCharacters(at: indexPath.row, isFiltering: isFiltering)
        let viewController = storyboard?.instantiateViewController(identifier: detailNavigationVCIdentifier)
        guard
            let navigationViewController = viewController as? UINavigationController,
            let detailViewController = navigationViewController.viewControllers.first as? DetailViewController
        else { return }
        detailViewController.viewModel = row
        //detailViewController.configure(with: viewModel.getProduct(for: indexPath))
        showDetailViewController(navigationViewController, sender: self)
    }
}

// MARK: - Search Controller Delegates

extension MasterListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        filterContentWithSearchText(text)
    }
    
    func filterContentWithSearchText(_ searchText: String) {
        _ = viewModel.filterCharacterList(for: searchText)
        tableView.reloadData()
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Character"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}
