//
//  HomeInteractor.swift
//  SpaceX
//
//  Created by Martin on 08/01/2024.
//

import Foundation

class HomeInteractor: Interactor
<
	HomeViewModel,
	HomePresenter
> {
	
	// MARK: - Workers
	private let weatherWorker = WeatherWorker()
	private var currentIndex: Int = 0
	private var currentCitationIndex: Int = 0
	private let towns: [Int] = [6432801, 2988507, 2990969, 3031582, 2996944]
	private let citations: [String] = ["Chargement..", "Veuillez patienter..", "Encore quelques instants.."]
	private var timer: Timer?
	private var citationTimer: Timer?
	
	func start() {
		// Récupérer les infos de la première ville
		self.presenter.hideComponent(true)
		
		self.presenter.display()
		
		self.fetchCity()
		
		// Lancer le timer
		self.timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { timer in
			if self.currentIndex >= self.towns.count {
				self.timer?.invalidate()
				self.citationTimer?.invalidate()
			} else {
				self.fetchCity()
			}
		})
		
		self.citationTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
			self.presenter.readCitation(citation: self.citations[self.currentCitationIndex % self.citations.count])
			self.presenter.display()
			self.currentCitationIndex += 1
		})
	}
	
	func fetchCity() {
		Task {
			do {
				let cityId = self.towns[self.currentIndex]
				self.currentIndex += 1
				let response = try await self.weatherWorker.fetchWeather(for: cityId)
				self.presenter.addCity(name: response.name)
				let progressValue = Float(currentIndex) / Float(towns.count)
				self.presenter.progress(newValue: progressValue)
				self.presenter.hideComponent(progressValue < 1)
				self.presenter.display()
			} catch {
				print(error)
			}
		}
	}
	
	func reset() {
		self.currentIndex = 0
		self.currentCitationIndex = 0
		self.presenter.hideComponent(false)
		self.presenter.progress(newValue: 0)
		self.presenter.resetCities()
		self.presenter.display()
		
	}
}

struct WeatherWorker {
	func fetchWeather(for cityId: Int) async throws -> WeatherResponse {
		return try await  WeatherRequest(cityId: cityId).response(WeatherResponse.self)
	}
}
