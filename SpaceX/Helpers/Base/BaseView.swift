//
//  BaseView.swift
//  ONP
//
//  Created by Michael Coqueret on 24/11/2023.
//

import Foundation
import UtilsKit
import UIKit

class BaseView: UIView {
	
	// MARK: - Init
	deinit {
		NotificationCenter.default.removeObserver(self)
		log(.custom("💀"), "Deinit \(String(describing: self))")
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		self.localize()
	}
}
