//
//  WeatherRequest.swift
//  SpaceX
//
//  Created by Thibault on 08/01/2024.
//

import Foundation
import NetworkUtilsKit

struct WeatherRequest: RequestProtocol {
	
	let cityId: Int
	
	var scheme: String = "https"
	
	var host: String = "api.openweathermap.org"
	
	var path: String = "/data/2.5/weather"		
	
	var method: NetworkUtilsKit.RequestMethod = .get
	
	var encoding: Encoding = .url
	
	var parameters: Parameters? {
		[
			"appid": "5bb8f2270611cba90d1e3c627ba750fc",
			"id": self.cityId
		]
	}
}

struct WeatherResponse: Decodable {
	let name: String
}
