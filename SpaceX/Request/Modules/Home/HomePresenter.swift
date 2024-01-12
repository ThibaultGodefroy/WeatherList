//
//  HomePresenter.swift
//  SpaceX
//
//  Created by Martin on 08/01/2024.
//

class HomePresenter: Presenter<HomeViewModel> {
	
	func addCity(name: String) {
		self.viewModel?.cityNames.append(name)
	}
	
	func progress(newValue: Float) {
		self.viewModel?.currentProgress = newValue
	}
	
	func hideComponent(_ value: Bool) {
		self.viewModel?.isHidden = value
	}
	
	func readCitation(citation: String?) {
		self.viewModel?.citation = citation
	}
	
	func resetCities() {
		self.viewModel?.cityNames = []
	}
}
