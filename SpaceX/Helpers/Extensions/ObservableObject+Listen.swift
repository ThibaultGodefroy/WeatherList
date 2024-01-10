//
//  ObservableObject+Listen.swift
//  ONP
//
//  Created by Michael Coqueret on 24/11/2023.
//

import Foundation
import Combine

extension ObservableObject {
	
	func listen(subscribers: inout Set<AnyCancellable>,
				scheduler: DispatchQueue = .main,
				completion: @escaping () -> Void) {
		self.objectWillChange
			.receive(on: scheduler)
			.sink { _ in
				completion()
			}
			.store(in: &subscribers)
	}
}
