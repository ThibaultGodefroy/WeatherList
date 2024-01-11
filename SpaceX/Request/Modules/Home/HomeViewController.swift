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
	@IBOutlet weak var startButton: UIButton!
	
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
//	
//	@IBAction func startTimer(_ sender: UIButton) {
//		
//		timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { timer in
//			self.p += 0.01
//			self.progressBar.progress = self.p
//			if self.progressBar.progress == 1  {
//				print("Loading finished..")
//			}
//		})
//	}
	
	@objc private func timerDidEnded() {
		time += 1
		print(time)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// Nombre de lignes a définir en fonction du nombre d'éléments dans le tableau de cityNames.
		self.viewModel.cityNames.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cityName = self.viewModel.cityNames
//		let town = self.viewModel.name?[indexPath.row]
		
		let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
		cell.label.text = cityName[indexPath.row]
		return cell
	}
	
	// MARK: - Refresh
	override func refreshUI() {
		super.refreshUI()
		
		self.table.reloadData()
		self.progressBar.setProgress(self.viewModel.currentProgress, animated: true)
	}
}
