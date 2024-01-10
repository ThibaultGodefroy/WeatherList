//
//  BaseCollectionViewCell.swift
//  ONP
//
//  Created by Michael Coqueret on 24/11/2023.
//

import Foundation
import UtilsKit
import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
	
	// MARK: - Localize
	override func awakeFromNib() {
		super.awakeFromNib()
		
		self.localize()
	}
}
