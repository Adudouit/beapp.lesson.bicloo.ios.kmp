//
//  StationsViewController.swift
//  Bicloo
//
//  Created by Anthony Dudouit on 13/09/2022.
//

import UIKit
import Combine
import BikeKit

class StationsViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	private let viewModel = StationsViewModel.shared
	private var cancellables: Set<AnyCancellable> = []
	private var stations: [StationEntity] = []

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(true)
		viewModel.$stations
			.sink { [weak self] stations_ in
				self?.stations = stations_
				self?.tableView.reloadData()
			}
			.store(in: &cancellables)

	}

	override func viewDidLoad() {
        super.viewDidLoad()

		self.tableView.register(UINib(nibName: "StationTableViewCell", bundle: nil), forCellReuseIdentifier: "StationTableViewCell")

		self.tableView.delegate = self
		self.tableView.dataSource = self
	}
}

extension StationsViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		viewModel.select(station: stations[indexPath.row])
	}
}

extension StationsViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.stations.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "StationTableViewCell", for: indexPath) as! StationTableViewCell
		cell.loadWith(self.stations[indexPath.row])
		return cell

	}


}
