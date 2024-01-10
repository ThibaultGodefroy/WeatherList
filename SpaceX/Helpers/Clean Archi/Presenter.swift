//  Presenter.swift
//
//  Created by Michael Coqueret on 24/11/2023.
//

import Foundation

class Presenter<V: ViewModel> {
	
	// MARK: Variables
	var viewModel: V?
	
	// MARK: - Init
	required init() { }
	
	func set(viewModel: V) {
		self.viewModel = viewModel
	}
	
	// MARK: - Display
	func display() {
		self.viewModel?.objectWillChange.send()
	}
	
	func display(loader: Bool) {
		self.viewModel?.isLoading = loader
	}
	
	// MARK: - Close
	func close() {
		self.viewModel?.needToClose = true
	}
}
