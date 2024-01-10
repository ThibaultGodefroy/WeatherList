//  Interactor.swift
//
//  Created by Michael Coqueret on 24/11/2023.
//

import Foundation

class Interactor<V: ViewModel, P: Presenter<V>> {
	
	// MARK: - Variables
	let presenter: P
	
	// MARK: - Init
	required init() {
		self.presenter = P()
	}
	
	func set(viewModel: V) {
		self.presenter.set(viewModel: viewModel)
	}
}
