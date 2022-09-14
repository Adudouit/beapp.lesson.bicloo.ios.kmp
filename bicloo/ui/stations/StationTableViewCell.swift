//
//  StationTableViewCell.swift
//  Bicloo
//
//  Created by Anthony Dudouit on 09/09/2022.
//

import UIKit

class StationTableViewCell: UITableViewCell {

	@IBOutlet weak var stationStateView: UIView!
	@IBOutlet weak var stationNameLabel: UILabel!
	@IBOutlet weak var stationAddressLabel: UILabel!

	func loadWith(_ station: StationEntity) {
		stationStateView.backgroundColor = station.state == .OPEN ? UIColor.systemMint : UIColor.systemRed
		stationNameLabel.text = station.name
		stationAddressLabel.text = station.address
	}
}
