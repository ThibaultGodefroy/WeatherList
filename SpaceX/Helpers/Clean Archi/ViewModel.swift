//
//  ViewModel.swift
//  Total
//
//  Created by Michael Coqueret on 18/06/2021.
//  Copyright © 2021 Exomind. All rights reserved.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
	
	class Listener<T>: ObservableObject {
		var value: T
		
		init(_ value: T) {
			self.value = value
		}
	}
	
	// MARK: - Variables

	// Loading
	var loaderListener = Listener<Bool>(false)
	var isLoading: Bool {
		get { self.loaderListener.value }
		set {
			self.loaderListener.value = newValue
			self.loaderListener.objectWillChange.send()
		}
	}
	
	// Close
	var closeListener = Listener<Bool>(false)
	var needToClose: Bool {
		get { self.closeListener.value }
		set {
			self.closeListener.value = newValue
			self.closeListener.objectWillChange.send()
		}
	}
	
	// MARK: - Init
	required init() { }
	
	func send() {
		DispatchQueue.main.async {
			self.objectWillChange.send()
		}
	}
}
