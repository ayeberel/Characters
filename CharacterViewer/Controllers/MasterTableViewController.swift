//  Created by ayu on 05/08/21.

import UIKit

class MasterListViewController: UITableViewController {
    private var detailNavigationVCIdentifier = "DetailNavVCIdentifier"
    var viewModel: CharacterViewModelable!

    override func viewDidLoad() {
        super.viewDidLoad()
        #if SIMPSONS
        viewModel = SimpsonsListViewModel()
        #else
        viewModel = WiresListViewModel()
        #endif
        viewModel.fetchData()
        viewModel.onCompletion = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.numberOfCharacters()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.getTitle(at: indexPath.row)
         return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        #if SIMPSONS
        let row = viewModel.getCharacters(at: indexPath.row) as? SimpsonsViewModel
        #else
        let row = viewModel.getCharacters(at: indexPath.row) as? WiresViewModel
        #endif
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
