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
	private var currentIndex = 0
	private let towns = [6432801, 2988507, 2990969, 3031582, 2996944]
	private var timer : Timer?
	
	
//	func refresh() {
//		Task {
//			do {
//				var cityNames: [String] = []
//				
//				let response = try await weatherWorker.fetchWeather(for: towns[currentIndex])
//				
//				currentIndex += 1
//				cityNames.append(response.name)
//				
//				self.presenter.display(cityName: cityNames)
//				try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
//				
//			} catch {
//				print(error)
//			}
//		}
//	}
	
	func start() {
		// Récupérer les infos de la première ville
		self.fetchCity()
		
		
		// Lancer le timer
		self.timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { timer in
			if self.currentIndex >= self.towns.count {
				self.timer?.invalidate()
			} else {
				self.fetchCity()
			}
		})
	}
	
	func fetchCity() {
		Task {
			do {
				let cityId = self.towns[self.currentIndex]
				self.currentIndex += 1
				let response = try await self.weatherWorker.fetchWeather(for: cityId)
				self.presenter.addCity(name: response.name)
				// afficher progress avec la fonction dans homePresenter
				self.presenter.progress(newValue:  Float(currentIndex) / Float(towns.count))
				self.presenter.display()
			} catch {
				print(error)
			}
		}
	}
}

struct WeatherWorker {
	
	func fetchWeather(for cityId: Int) async throws -> WeatherResponse {
		return try await  WeatherRequest(cityId: cityId).response(WeatherResponse.self)
	}
}
