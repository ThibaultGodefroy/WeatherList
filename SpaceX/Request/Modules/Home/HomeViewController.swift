//
//  HomeViewController.swift
//  SpaceX
//
//  Created by Martin on 08/01/2024.
//
import UIKit

class HomeViewController: BaseViewController
<
	HomeViewModel,
	HomePresenter,
	HomeInteractor
>, UITableViewDataSource {
	
	// MARK: - Outlets
	
	// MARK: - Variables
	@IBOutlet weak var table: UITableView!
	@IBOutlet weak var label: UILabel!
	
	// MARK: - View life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.interactor.refresh()
		table.dataSource = self
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// Nombre de lignes a définir en fonction du nombre d'éléments dans le tableau de cityNames.
		self.viewModel.cityNames?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cityName = self.viewModel.cityNames!
//		let town = self.viewModel.name?[indexPath.row]
		
		let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
		cell.label.text = cityName[indexPath.row]
		return cell
	}
	
	// MARK: - Refresh
	override func refreshUI() {
		super.refreshUI()
		
		self.table.reloadData()
	}
}
