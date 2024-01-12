//
//  HomePresenter.swift
//  SpaceX
//
//  Created by Martin on 08/01/2024.
//

class HomePresenter: Presenter<HomeViewModel> {
	
	func display(cityName: [String]) {
		self.viewModel?.cityNames = cityName
		self.viewModel?.send()
	}
	
	func addCity(name: String) {
		self.viewModel?.cityNames.append(name)
	}
	
	func progress(newValue: Float) {
		self.viewModel?.currentProgress = newValue
	}
}
