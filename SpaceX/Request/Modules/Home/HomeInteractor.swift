//
//  HomeInteractor.swift
//  SpaceX
//
//  Created by Martin on 08/01/2024.
//

class HomeInteractor: Interactor
<
	HomeViewModel,
	HomePresenter
> { 	
	
	// MARK: - Workers
	private let weatherWorker = WeatherWorker()
	
	func refresh() {
		Task {
			do {
				// Presenter maj array cities
				let towns = [6432801, 2988507, 2990969, 3031582, 2996944]
				var cityNames: [String] = []
//				let response = try await self.weatherWorker.fetchWeather(for: 6432801)
			
				for town in towns {
					let response = try await weatherWorker.fetchWeather(for: town)
					cityNames.append(response.name)
					print(response)
					self.presenter.display(cityName: cityNames)
				}
				print(cityNames)
			
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
