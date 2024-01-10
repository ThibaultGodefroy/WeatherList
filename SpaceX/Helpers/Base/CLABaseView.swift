//
//  CLABaseView.swift
//  ONP
//
//  Created by Michael Coqueret on 24/11/2023.
//

import Foundation
import UIKit
//import UtilsKit
import Combine

class CLABaseView
<
	V: ViewModel,
	P: Presenter<V>,
	I: Interactor<V, P>
>: BaseView {
	
	// MARK: - Variables
	// MARK: Clean Archi
	var viewModel = V() {
		didSet {
			self.configureViewModel(for: &self.interactor)
		}
	}
	
	lazy var interactor: I = {
		let interactor = I()
		interactor.set(viewModel: self.viewModel)
		return interactor
	}()
	
	private var subscribers = Set<AnyCancellable>()
	
	// MARK: - Init
	deinit {
		self.stopLoading()
	}
	
	// MARK: - Configure viewModel
	private func configureViewModel(for interactor: inout I) {
		self.subscribers.removeAll()
		
		self.viewModel.listen(subscribers: &self.subscribers) { [weak self] in
			self?.refreshUI()
		}
		
		self.viewModel.loaderListener.listen(subscribers: &self.subscribers) { [weak self] in
			self?.refreshLoader()
		}
		
		interactor.set(viewModel: self.viewModel)
	}
	
	// MARK: - Refresh
	func refreshUI() { }
	
	private func refreshLoader() {
		if self.viewModel.isLoading {
			self.startLoading()
		} else {
			self.stopLoading()
		}
	}
	
	// MARK: - Loading
	func startLoading() {
		//TODO: Loading
	}
	
	func stopLoading() {
		//TODO: Loading
	}
}
