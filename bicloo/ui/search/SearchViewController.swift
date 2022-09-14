//
//  SearchViewController.swift
//  Bicloo
//
//  Created by Anthony Dudouit on 13/09/2022.
//

import UIKit
import Combine

class SearchViewController: UIViewController {

	private let searchController = UISearchController(searchResultsController: nil)
	private let viewModel = CitySelectionViewModel()
	private var cancellables: Set<AnyCancellable> = []
	private var contracts: [ContractEntity] = []

	@IBOutlet weak var tableView: UITableView!

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		viewModel.$contracts
			.sink { [weak self] contracts in
				self?.contracts = contracts
				self?.tableView.reloadData()
			}
			.store(in: &cancellables)
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		title = "Recherche"

		searchController.searchBar.delegate = self
		searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false

		searchController.searchBar.placeholder = "Rechercher une ville"

		navigationItem.searchController = searchController

		tableView.delegate = self
		tableView.dataSource = self

    }
}
extension SearchViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		if let search = searchController.searchBar.text {
			print(search)
			viewModel.searchForContract(search)
		}
	}


}
extension SearchViewController: UISearchBarDelegate {

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		if let search = searchBar.text {
			print(search)
		}
	}
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		self.contracts.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: "UITableviewCell")
		if cell == nil {
			cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "UITableviewCell")
		}

		cell?.textLabel?.text = self.contracts[indexPath.row].name
		return cell!

	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.navigationController?.pushViewController(ResultPagerViewController(contract: self.contracts[indexPath.row]), animated: true)
	}


}
