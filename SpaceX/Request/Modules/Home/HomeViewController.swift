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
	@IBOutlet weak var table: UITableView!
	@IBOutlet weak var progressBar: UIProgressView!
	@IBOutlet weak var restartButton: UIButton!
	@IBOutlet weak var loadingCitations: UILabel!
	
	// MARK: - Variables
	var time = 0
	var timer = Timer()
	var p: Float = 0.0
	
	// MARK: - View life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		table.dataSource = self
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.interactor.start()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		self.viewModel.cityNames.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cityName = self.viewModel.cityNames
		let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
		cell.label.text = cityName[indexPath.row]
		return cell
	}
	
	// MARK: - Refresh
	override func refreshUI() {
		super.refreshUI()
		self.table.reloadData()
		self.progressBar.setProgress(self.viewModel.currentProgress, animated: self.viewModel.currentProgress > 0)
		self.restartButton.isHidden = self.viewModel.isHidden
		self.loadingCitations.text = self.viewModel.citation
		self.loadingCitations.isHidden = !self.viewModel.isHidden
	}
	
	@IBAction func reload() {
		self.interactor.reset()
		self.interactor.start()
	}
}
