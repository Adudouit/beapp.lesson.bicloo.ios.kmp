//
//  ResultPagerViewController.swift
//  Bicloo
//
//  Created by Anthony Dudouit on 13/09/2022.
//

import UIKit
import Combine
import BikeKit

class ResultPagerViewController: UIViewController {

	@IBOutlet weak var pagerContainer: UIView!
	@IBOutlet weak var segmentedControl: UISegmentedControl!

	private var pageController: UIPageViewController?
	private var contract: ContractEntity!
	private let viewModel = StationsViewModel.shared
	private var cancellables: Set<AnyCancellable> = []

	private(set) var orderedViewControllers: [UIViewController] = {
		return [
			StationsViewController(),
			MapViewController()
		]
	}()

	convenience init(contract: ContractEntity) {
		self.init()
		self.contract = contract
	}


	override func viewDidLoad() {
        super.viewDidLoad()
		self.setupPager()
		title = contract.name
		viewModel.fetchStations(contract: contract)
	}


	func setupPager() {
		self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
		self.pageController?.view.frame = CGRect(x: 0, y: 0, width: self.pagerContainer.frame.width, height: self.pagerContainer.frame.height)

		self.addChild(self.pageController!)
		self.pagerContainer.addSubview(self.pageController!.view)
		self.pageController?.setViewControllers([orderedViewControllers[0]], direction: .forward, animated: true, completion: nil)

		self.pageController?.didMove(toParent: self)
	}

	@IBAction func onSegmentedControlValueChanged(_ sender: Any) {

		switch segmentedControl.selectedSegmentIndex {
		case 0:
			pageController?.setViewControllers([orderedViewControllers[0]], direction: .reverse, animated: true, completion: nil)

		default:
			pageController?.setViewControllers([orderedViewControllers[1]], direction: .forward, animated: true, completion: nil)
		}
	}
}
