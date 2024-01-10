//  BaseViewController.swift
//
//  Created by Michael Coqueret on 24/11/2023.
//

import Foundation
import UIKit
import Combine
import UtilsKit

class BaseViewController
<
	V: ViewModel,
	P: Presenter<V>,
	I: Interactor<V, P>
>:
	UIViewController,
	NavigationProtocol {
	
	
	// MARK: - Variables
	// MARK: Navigation
	var navigationSegue: UtilsKit.Segue?
	var instanceIdentifier: String?
	var previousViewController: UIViewController?
	
	// MARK: Clean Archi
	var viewModel = V() {
		didSet {
			self.configureViewModel(for: &self.interactor)
		}
	}
	
	lazy var interactor: I = {
		var interactor = I()
		self.configureViewModel(for: &interactor)
		return interactor
	}()
	
	private var subscribers = Set<AnyCancellable>()
	
	// MARK: - View life cycle
	deinit {
		self.stopLoading()
		NotificationCenter.default.removeObserver(self)
		print("💀 Deinit \(String(describing: self))")
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		self.stopLoading()
	}
	
	func viewWillPresent(controller: UIViewController?, completion: @escaping () -> Void) { }
	
	// MARK: - Configure viewModel
	private func configureViewModel(for interactor: inout I) {
		self.subscribers.removeAll()
		
		self.viewModel.listen(subscribers: &self.subscribers) { [weak self] in
			if self?.isViewLoaded ?? false {
				self?.refreshUI()
			}
		}
		
		self.viewModel.loaderListener.listen(subscribers: &self.subscribers) { [weak self] in
			if self?.isViewLoaded ?? false {
				self?.refreshLoader()
			}
		}
		
		self.viewModel.closeListener.listen(subscribers: &self.subscribers) { [weak self] in
			if self?.viewModel.needToClose ?? false {
				self?.close()
			}
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
